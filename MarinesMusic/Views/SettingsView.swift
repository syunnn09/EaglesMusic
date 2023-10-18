//
//  SettingsView.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/16.
//

import SwiftUI

struct SettingsView: View {
    @State var isStopOtherAppSound = getPref(forKey: .isStopOtherAppSound)
    @State var isDuckOthers = getPref(forKey: .isDuckOthers)
    @State var isArrowBackground = getPref(forKey: .isArrowBackground)
    @State var isModalClickToStop = getPref(forKey: .isModalClickToStop)

    var body: some View {
        VStack {
            List {
                Toggle("他アプリの音声を停止する", isOn: $isStopOtherAppSound)
                    .onChange(of: isStopOtherAppSound) { value in
                        setPref(forKey: .isStopOtherAppSound, value: value)
                    }

                Toggle("他アプリの音声を小さくする", isOn: $isDuckOthers)
                    .disabled(isStopOtherAppSound)
                    .onChange(of: isDuckOthers) { value in
                        setPref(forKey: .isDuckOthers, value: value)
                    }

    //            Toggle("バックグラウンド再生を許可", isOn: $isArrowBackground)
    //                .onChange(of: isArrowBackground) { _, value in
    //                    setPref(forKey: .isArrowBackground, value: value)
    //                }

                Toggle("背景タップで再生を停止する", isOn: $isModalClickToStop)
                    .onChange(of: isModalClickToStop) { value in
                        setPref(forKey: .isModalClickToStop, value: value)
                    }
                
            }
        }
    }
}

#Preview {
    SettingsView()
}
