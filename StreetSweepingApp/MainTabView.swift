//
//  MainTabView.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//


//
//  MainTabView.swift
//  DevLearnHub
//
//  Created by Kelly Lampotang on 7/8/26.
//

import SwiftUI

struct MainTabView: View {
    @Environment(AppSettings.self) private var settings
    var body: some View {
        @Bindable var settings = settings
        // struct that takes a trailing closure containing its child views
        TabView(selection: $settings.selectedTab) {
            MapScreen()
                .tabItem {
                    Label("Map", systemImage: "map.circle")
                }
                .tag(AppSettings.TabIdentifier.map)
            Preferences()
                .tabItem {
                    Label("Preferences", systemImage: "gear")
                }
                .tag(AppSettings.TabIdentifier.preferences)
        }
        .accentColor(settings.themeColor)
    }
}

#Preview {
    MainTabView()
        .environment(AppSettings())
}
