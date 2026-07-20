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
    @Published private(set) var features: [LiveSweepingFeature] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    func fetchSweepingSchedules(for day: DayOfWeek, near coordinate: CLLocationCoordinate2D? = nil) async {
        self.isLoading = true
        let dayString = day.apiDayString
        
        var urlComponents = URLComponents(string: APIConstants.apiUrl)!
        var queryItems = [URLQueryItem(name: APIConstants.weekdayKey, value: dayString)]
        
        if let coord = coordinate {
            let latMin = coord.latitude - MapConstants.searchRadiusDegrees
            let latMax = coord.latitude + MapConstants.searchRadiusDegrees
            let lonMin = coord.longitude - MapConstants.searchRadiusDegrees
            let lonMax = coord.longitude + MapConstants.searchRadiusDegrees
            
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
            if (error as? URLError)?.code == .cancelled { return }
            errorMessage = "Error fetching sweeping data from API: \(error)"
        }
        
        self.isLoading = false
    }
}
