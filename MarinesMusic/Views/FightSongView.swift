//
//  FightSongView.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/16.
//

import SwiftUI
import AVFoundation

struct FightSongView: View {
    @ObservedObject var player = AVPlayerController()

    @State var showPlayer: Player?
    @State var isShowLyric = false
    @State var isActiveOnly = false
    @State var isFavoriteOnly = false
    @State var selectedPlayerIsFavorite: Bool?

    @State var favorites = getFavorites()

    var feedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    var isShowPauseButton: Bool {
        return !isShowLyric && isPlaying
    }

    var isPlaying: Bool {
        return player.isPlaying
    }

    var players: [Player] {
        var players = getData()

        if isFavoriteOnly {
            players = players.filter { player in
                return favorites.contains(player.id)
            }
        }

        if !isActiveOnly { return players }

        return players.filter { player in
            return player.isActive
        }
    }

    init() {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
            print("audio session set active failure")
        }
    }

    func isFavorite(player: Player) -> Bool {
        return favorites.contains(player.id)
    }

    func playMusic(name: String) {
        player.play(name: name)
    }

    func stopMusic(isStop: Bool=true) {
        withAnimation(.easeInOut(duration: 0.5)) {
            isShowLyric = false
            if isStop {
                player.stop()
                showPlayer = nil
                selectedPlayerIsFavorite = nil
            }
        }
    }

    func setFav(id: Int) {
        feedbackGenerator.impactOccurred()
        selectedPlayerIsFavorite?.toggle()
        self.favorites = setFavorite(id: id)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Toggle(isOn: $isActiveOnly) {
                        Text("在籍選手のみ表示")
                    }
                    .padding([.top, .horizontal])

                    Toggle(isOn: $isFavoriteOnly) {
                        Text("お気に入りのみ表示")
                    }
                    .padding(.horizontal)

                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 15) {
                            ForEach(players, id: \.self) { player in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isShowLyric = true
                                    }
                                    if isPlaying && showPlayer == player { return }

                                    selectedPlayerIsFavorite = isFavorite(player: player)
                                    showPlayer = player
                                    playMusic(name: player.enName)
                                } label: {
                                    HStack(spacing: 3) {
                                        Star(isStar: favorites.contains(player.id)) {
                                            setFav(id: player.id)
                                        }
                                        Text(player.jpName)
                                    }
                                    .padding(.horizontal)
                                    .frame(width: geometry.size.width / 2 - 30, alignment: .leading)
                                }
                                .buttonStyle(PlayButtonStyle(width: geometry.size.width, isSelected: isPlaying && showPlayer == player))
                            }
                        }
                        .padding(.bottom, isShowPauseButton ? 60 : 0)
                        .padding(.top, 2)
                    }
                    .padding()
                }
                .zIndex(0)

                LyricView(
                    isShow: $isShowLyric,
                    isFavorite: $selectedPlayerIsFavorite,
                    width: geometry.size.width,
                    player: showPlayer,
                    closeCallback: { stopMusic() },
                    setFab: { id in setFav(id: id) }
                )
                .zIndex(3)
                .offset(y: isShowLyric ? 0 : geometry.size.height * 2)
                
                if isShowLyric {
                    Button {
                        stopMusic(isStop: getPref(forKey: .isModalClickToStop))
                    } label: {
                        Text("")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.gray.opacity(0.5))
                    }
                    .zIndex(2)
                    .buttonStyle(ModalButton())
                }

                VStack {
                    Spacer()
                    Button() {
                        stopMusic()
                    } label: {
                        Text("再生停止")
                    }
                    .buttonStyle(PauseButton(width: geometry.size.width))
                    .offset(y: isShowPauseButton ? 0 : geometry.size.height)
                    .padding(.bottom)
                }
                .zIndex(1)
            }
        }
    }
}

#Preview {
    FightSongView()
}
