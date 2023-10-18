//
//  ContentView.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/15.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        TabView {
            FightSongView()
                .tabItem {
                    Label("応援歌", systemImage: "megaphone")
                }
            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
