//
//  MapKeyView.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI

struct MapKeyView: View {
    @Environment(AppSettings.self) private var settings

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(settings.rightColor)
                    .frame(width: 16.0, height: 16.0)
                Text("Right")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            HStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(settings.leftColor)
                    .frame(width: 16.0, height: 16.0)
                Text("Left")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(.gray)
        .cornerRadius(5)
    }
}

#Preview {
    MapKeyView()
        .environment(AppSettings())
}
