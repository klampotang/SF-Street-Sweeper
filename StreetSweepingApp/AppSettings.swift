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
    static let defaultThemeColor: Color = .blue
    static let defaultLeftColor: Color = .orange
    static let defaultRightColor: Color = .green

    enum TabIdentifier: Int {
        case map = 0
        case preferences = 1
    }
    var selectedTab: TabIdentifier = .map

    var themeColor: Color = Color(hex: UserDefaults.standard.string(forKey: "themeColor") ?? "") ?? defaultThemeColor {
        didSet { UserDefaults.standard.set(themeColor.toHex(), forKey: "themeColor") }
    }
    var leftColor: Color = Color(hex: UserDefaults.standard.string(forKey: "leftColor") ?? "") ?? defaultLeftColor {
        didSet { UserDefaults.standard.set(leftColor.toHex(), forKey: "leftColor") }
    }
    var rightColor: Color = Color(hex: UserDefaults.standard.string(forKey: "rightColor") ?? "") ?? defaultRightColor {
        didSet { UserDefaults.standard.set(rightColor.toHex(), forKey: "rightColor") }
    }
}
