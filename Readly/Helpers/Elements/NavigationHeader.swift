//
//  NavigationHeader.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//

import SwiftUI

struct NavigationHeader: View {
    var title: String
    var action: () -> ()
    var body: some View {
        HStack{
            Button {
                action()
            }
            label: {
                Image (systemName: "arrow.left")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.white)
            }
            Spacer()
            Text(title)
                .font(type: .black, size: 20)
                .frame(width: 250)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundStyle(.white)
            Spacer()
            Rectangle()
                .opacity (0)
                .frame(width: 20, height: 20)
        }
    }
}
