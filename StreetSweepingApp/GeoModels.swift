//
//  GeoModels.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//


import Foundation
import CoreLocation

struct GeoJSONFeatureCollection: Decodable {
    let features: [LiveSweepingFeature]
}

struct LiveSweepingFeature: Decodable, Identifiable {
    var id: String { properties.blocksweepid ?? UUID().uuidString }
    let geometry: LiveGeometry?
    let properties: LiveProperties
}

struct LiveGeometry: Decodable {
    let type: String // "LineString"
    let coordinates: [[Double]] // [[longitude, latitude]]
    
    var clCoordinates: [CLLocationCoordinate2D] {
        coordinates.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
    }
}

struct LiveProperties: Decodable {
    let cnn: String?
    let corridor: String?       // Street name
    let limits: String?         // Between Cross streets
    let cnnrightleft: String?   // "L" or "R"
    let fromhour: String?       // e.g. "13"
    let tohour: String?         // e.g. "15"
    let blocksweepid: String?
    
    // SF DataSF returns week flags as strings "1" or "0" via API
    let week1: String?
    let week2: String?
    let week3: String?
    let week4: String?
    let week5: String?
}
