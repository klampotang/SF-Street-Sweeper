//
//  AppConstants.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI

enum AppColor {
    static let left: Color = .orange
    static let right: Color = .green
}

enum MapConstants {
    static let searchRadiusDegrees: CGFloat = 0.005
    static let lineThickness: Int = 4
    static let progressViewPadding = 8.0
    static let progressViewCornerRadius = 8.0
}


enum APIConstants {
    static let apiUrl = "https://data.sfgov.org/resource/yhqp-riqs.geojson"
    static let weekdayKey = "weekday"
}
