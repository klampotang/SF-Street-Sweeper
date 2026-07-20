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
                            feature.properties.cnnrightleft == "R" ? AppColor.right : AppColor.left,
                            lineWidth: 4
                        )
                }
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            .overlay(alignment: .bottomLeading) {
                MapKeyView()
                    .padding(30)
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Updating streets...")
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
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
