//
//  SavedParking.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI

struct Preferences: View {
    @Environment(AppSettings.self) private var settings
    
    var body: some View {
        // Create local bindable reference to allow bindings
        @Bindable var settings = settings
        
        NavigationStack {
            Form {
                Section(header: Text("Preferences")) {
                    ColorPicker("Accent Color", selection: $settings.themeColor)
                }
            }
            .navigationTitle("Preferences")
        }
    }
}

#Preview {
    Preferences()
        .environment(AppSettings())
}

