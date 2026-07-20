//
//  AppConstants.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI

enum MapConstants {
    static let searchRadiusDegrees: CGFloat = 0.005
    static let lineWidth = 4.0
    static let progressViewPadding = 8.0
    static let progressViewCornerRadius = 8.0
    static let keyPadding = 30.0
}

enum APIConstants {
    static let apiUrl = "https://data.sfgov.org/resource/yhqp-riqs.geojson"
    static let weekdayKey = "weekday"
    static let limitKey = "$limit"
    static let limit = "10000"
}
