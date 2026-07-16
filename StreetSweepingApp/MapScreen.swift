//
//  MapScreen.swift
//  StreetSweepingApp
//
//  Created by Kelly lampotang on 7/15/26.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(followsHeading: true, fallback: .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 37.7693,
                longitude: -122.4299
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.008,
                longitudeDelta: 0.008
            )
        )
    ))
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .ignoresSafeArea()
            
            PermissionBanner(locationManager: locationManager)
                .padding()
        }
        .onAppear {
            locationManager.start()
        }
    }
}

#Preview {
    MapScreen()
}
