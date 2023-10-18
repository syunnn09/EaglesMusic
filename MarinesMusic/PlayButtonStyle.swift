//
//  PlayButtonStyle.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/15.
//

import Foundation
import SwiftUI

struct PlayButtonStyle: ButtonStyle {
    let width: CGFloat
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .padding()
            .frame(width: width / 2 - 30)
            .background(.gray)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: isSelected ? 1 : 0)
            )
    }
}

struct ModalButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct PauseButton: ButtonStyle {
    let width: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(width: width - 30)
            .foregroundStyle(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
