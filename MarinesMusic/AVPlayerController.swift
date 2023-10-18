//
//  AVPlayerController.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/18.
//

import Foundation
import AVFAudio
import UIKit
import SwiftUI

class AVPlayerController: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    func play(name: String) {
        if (((audioPlayer?.isPlaying) != nil)) { audioPlayer?.stop() }

        let isStopOtherAppSound = getPref(forKey: .isStopOtherAppSound)
        let isDuckOthers = getPref(forKey: .isDuckOthers)
        let option: AVAudioSession.CategoryOptions = isStopOtherAppSound ? .overrideMutedMicrophoneInterruption : isDuckOthers ? .duckOthers : .mixWithOthers

        let musicData = NSDataAsset(name: name)!.data

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: option)
            audioPlayer = try AVAudioPlayer(data: musicData)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print(error.localizedDescription)
        }
    }

    func stop() {
        audioPlayer?.stop()
        withAnimation(.linear(duration: 0.5)) {
            isPlaying = false
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        withAnimation(.linear(duration: 0.5)) {
            isPlaying = false
        }
    }
}
