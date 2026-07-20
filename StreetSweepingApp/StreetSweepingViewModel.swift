//
//  StreetSweepingViewModel.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//
import SwiftUI
import Foundation
import CoreLocation
import Combine

@MainActor
class StreetSweepingViewModel: ObservableObject {
    @Published var features: [LiveSweepingFeature] = []
    @Published var isLoading = false
    
    // Map human-readable days to the exact string tokens DataSF expects
    func apiDayString(for day: DayOfWeek) -> String {
        switch day {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tues"
        case .wednesday: return "Wed"
        case .thursday: return "Thurs"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
    
    func fetchSweepingSchedules(for day: DayOfWeek, near coordinate: CLLocationCoordinate2D? = nil) async {
        self.isLoading = true
        let dayString = apiDayString(for: day)
        
        var urlComponents = URLComponents(string: "https://data.sfgov.org/resource/yhqp-riqs.geojson")!
        var queryItems = [URLQueryItem(name: "weekday", value: dayString)]
        
        if let coord = coordinate {
            let latMin = coord.latitude - 0.005
            let latMax = coord.latitude + 0.005
            let lonMin = coord.longitude - 0.005
            let lonMax = coord.longitude + 0.005
            
            // SoQL Bounding Box syntax: within_box(geometry_column, lat_north, lon_west, lat_south, lon_east)
            let boxQuery = "within_box(line, \(latMax), \(lonMin), \(latMin), \(lonMax))"
            queryItems.append(URLQueryItem(name: "$where", value: boxQuery))
        }
        
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.setValue(Config.dataSFAppToken, forHTTPHeaderField: "X-App-Token")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.isLoading = false
                return
            }
            
            let decodedData = try JSONDecoder().decode(GeoJSONFeatureCollection.self, from: data)
            self.features = decodedData.features
        } catch {
            print("Error fetching sweeping data from API: \(error)")
        }
        
        self.isLoading = false
    }
}
