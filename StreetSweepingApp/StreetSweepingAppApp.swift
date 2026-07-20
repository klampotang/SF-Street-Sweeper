//
//  StreetSweepingAppApp.swift
//  StreetSweepingApp
//
//  Created by Kelly lampotang on 7/15/26.
//

import SwiftUI

@main
struct StreetSweepingAppApp: App {
    @State private var settings = AppSettings() // state is used to instantiate and own our observable classes at the root level

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(settings)
        }
    }
}
