//
//  PermissionBanner.swift
//  StreetSweepingApp
//
//  Created by Kelly lampotang on 7/15/26.
//

import SwiftUI
import CoreLocation

struct PermissionBanner: View {
    @ObservedObject var locationManager: LocationManager
    var body: some View {
        switch locationManager.authorizationStatus {
            case .notDetermined:
                Text("Please allow StreetSweepingApp to access your location.")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
        case .denied, .restricted:
            VStack(alignment: .leading, spacing: 8) {
                Label(
                    "Location access is disabled",
                    systemImage: "location.slash"
                )
                .font(.headline)
                
                Text(
                    "Enable location access in Settings to follow your position."
                )
                .font(.subheadline)
            }
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        case .authorizedAlways, .authorizedWhenInUse:
            EmptyView()
        default:
            EmptyView()
        }
    }
}
