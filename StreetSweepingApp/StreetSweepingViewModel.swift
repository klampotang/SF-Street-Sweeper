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
import MapKit

@MainActor
class StreetSweepingViewModel: ObservableObject {
    @Published private(set) var features: [LiveSweepingFeature] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    func fetchSweepingSchedules(for day: DayOfWeek, in region: MKCoordinateRegion? = nil) async {
        self.isLoading = true
        let dayString = day.apiDayString
        
        var urlComponents = URLComponents(string: APIConstants.apiUrl)!
        var queryItems = [
            URLQueryItem(name: APIConstants.weekdayKey, value: dayString),
            URLQueryItem(name: APIConstants.limitKey, value: APIConstants.limit)
            ]
        
        if let region = region {
            let padding = 1.2
            let halfLatDelta = (region.span.latitudeDelta * padding) / 2.0
            let halfLonDelta = (region.span.longitudeDelta * padding) / 2.0
            let latMin = region.center.latitude - halfLatDelta
            let latMax = region.center.latitude + halfLatDelta
            let lonMin = region.center.longitude - halfLonDelta
            let lonMax = region.center.longitude + halfLonDelta
            
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
