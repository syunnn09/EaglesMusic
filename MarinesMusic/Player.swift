//
//  Player.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/16.
//

import Foundation

struct Player: Hashable, Decodable {
    let id: Int
    let enName: String
    let jpName: String
    let lyric: String
    let isActive: Bool
}

extension Player {
    static let sample = Player(
        id: 1,
        enName: "takahama",
        jpName: "高濱卓也",
        lyric: "ラララ...(髙濱) * 2\n湧き上がるその闘志\n今だ 解き放て 高濱",
        isActive: false
    )
}
