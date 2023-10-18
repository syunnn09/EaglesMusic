//
//  LyricView.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/15.
//

import SwiftUI

struct LyricView: View {
    @Binding var isShow: Bool
    @Binding var isFavorite: Bool?
    var width: CGFloat
    var player: Player?

    var closeCallback: () -> Void
    var setFab: (_ id: Int) -> Void

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Star(isStar: isFavorite ?? false) {
                        setFab(player?.id ?? 0)
                    }

                    Text(player?.jpName.replacingOccurrences(of: "\n", with: "") ?? "")
                        .font(.title3)
                }

                Button {
                    closeCallback()
                } label: {
                    Image(systemName: "xmark")
                }
                .frame(maxWidth: width * 0.8, alignment: .trailing)
            }
            .padding(.bottom)

            Text(player?.lyric ?? "")
                .padding(.horizontal)
                .frame(maxWidth: width * 0.8, alignment: .leading)
        }
        .padding()
        .background(.white)
        .foregroundStyle(.black)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    LyricView(isShow: .constant(true), isFavorite: .constant(false), width: UIScreen.main.bounds.width, player: .sample, closeCallback: {}, setFab: { id in })
}
