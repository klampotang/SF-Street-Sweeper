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
    @StateObject private var viewModel = StreetSweepingViewModel()
    @Environment(AppSettings.self) private var settings
    
    @State private var dayOfWeek: DayOfWeek = .sunday
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
                
                ForEach(viewModel.features) { feature in
                    MapPolyline(coordinates: feature.geometry.clCoordinates)
                        .stroke(
                            feature.properties.cnnrightleft == "R" ? settings.rightColor : settings.leftColor,
                            lineWidth: MapConstants.lineWidth
                        )
                }
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            .overlay(alignment: .bottomLeading) {
                MapKeyView()
                    .padding(MapConstants.keyPadding)
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            
            if viewModel.isLoading {
                ProgressView("Updating streets...")
                    .padding(MapConstants.progressViewPadding)
                    .background(.ultraThinMaterial)
                    .cornerRadius(MapConstants.progressViewCornerRadius)
            }
            
            if viewModel.errorMessage != nil {
                
            }
            
            Menu {
                ForEach(DayOfWeek.allCases) { day in
                    Button {
                        dayOfWeek = day
                    } label: {
                        Text(day.name)
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(dayOfWeek.name)
                        .font(.title3)
                        .bold()
                    Image(systemName: "chevron.up.chevron.down")
                }
                .padding(5)
                .background(.thinMaterial)
                .cornerRadius(8)
                .padding(.top, 14)
            }
            
            PermissionBanner(locationManager: locationManager)
                .padding()
        }
        .onAppear {
            setDayOfWeek()
            locationManager.start()
        }
        .task(id: dayOfWeek) {
            await viewModel.fetchSweepingSchedules(for: dayOfWeek)
        }
        .alert("Something went wrong", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("Try again") {
                Task {
                    await viewModel.fetchSweepingSchedules(for: dayOfWeek)
                }
            }
            Button("Okay", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred.")
        }
    }
    
    private func setDayOfWeek() {
        let date = Date()
        let weekdayIndex = Calendar.current.component(.weekday, from: date)
        dayOfWeek = DayOfWeek(rawValue: weekdayIndex) ?? .sunday
    }
}

#Preview {
    MapScreen()
}
