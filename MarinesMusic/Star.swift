//
//  Star.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/17.
//

import SwiftUI

struct Star: View {
    var isStar: Bool
    var callback: () -> Void?

    var body: some View {
        Button {
            callback()
        } label: {
            ZStack {
                Image(systemName: "star")
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .opacity(isStar ? 1 : 0)
            }
            .font(.subheadline)
        }
    }
}

#Preview {
    Star(isStar: true) { }
}
