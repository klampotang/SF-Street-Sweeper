//
//  MapKeyView.swift
//  StreetSweepingApp
//
//  Created by Kelly Lampotang on 7/20/26.
//

import SwiftUI

struct MapKeyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(AppColor.right)
                    .frame(width: 16.0, height: 16.0)
                Text("Right")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            HStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(AppColor.left)
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
}
