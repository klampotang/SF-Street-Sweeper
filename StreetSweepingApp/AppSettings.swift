//
//  AppSettings.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI
import Observation

@Observable
class AppSettings {
    static let defaultThemeColor: Color = .brown

    enum TabIdentifier: Int {
        case map = 0
        case preferences = 1
    }
    var selectedTab: TabIdentifier = .map
    var themeColor: Color = defaultThemeColor
    var shouldStoreParking: Bool = false
}
