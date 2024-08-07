//
//  AudiobookPlayer.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 06.08.2024.
//

import AVFoundation

final class PlayerViewModel: NSObject, ObservableObject {
    
    // MARK: - SkipDirection
    
    enum SkipDirection {
        case forward
        case backward
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let keyPointFileName: String = "keyPoints"
    }
    
    // MARK: - Properties
    
    @Published private(set) var duration: Double = .zero
    @Published private(set) var currenKeyPointIndex: Int = .zero
    @Published private(set) var keyPoints: [BookKeyPoint] = []
    @Published var isShowingErrorAlert = true
    @Published var isPlayerOpen = true
    @Published var sliderValue: Double = .zero
    @Published var playbackSpeed: PlaybackSpeed = .x1 {
        didSet {
            setPlaybackSpeed()
        }
    }
    
    // MARK: - Private properties
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    // MARK: - Methods
    
    /// Start player
    func start() {
        loadKeyPoints(from: Constants.keyPointFileName)
        switchChapter(to: .zero)
        player?.play()
        startTimer()
    }
    
    /// Skip to next/previous key point
    func skipKeyPoint(_ direction: SkipDirection) {
        switch direction {
        case .forward:
            guard (0..<keyPoints.count).contains(currenKeyPointIndex + 1) else {
                return
            }
            currenKeyPointIndex += 1
        case .backward:
            guard (0..<keyPoints.count).contains(currenKeyPointIndex - 1) else {
                return
            }
            currenKeyPointIndex -= 1
        }
        switchChapter(to: currenKeyPointIndex)
        player?.play()
        sliderValue = .zero
        setPlaybackSpeed()
    }
    
    /// Play/pause audio
    func playPause() {
        guard let player = player else {
            return
        }
        if player.isPlaying {
            player.pause()
            stopTimer()
        } else {
            player.play()
            startTimer()
        }
    }
    
    /// Rewind back audio for 5 seconds
    func rewind() {
        guard let audioPlayer = player else {
            return
        }
        audioPlayer.currentTime = max(0, audioPlayer.currentTime - 5)
    }
    
    /// Fast forward audio for 10 seconds
    func fastForward() {
        guard let audioPlayer = player else {
            return
        }
        audioPlayer.currentTime = min(audioPlayer.duration, audioPlayer.currentTime + 10)
    }
    
    /// Update slider value
    func updateSliderValue() {
        guard let currentTime = player?.currentTime else {
            return
        }
        sliderValue = currentTime
    }
    
    /// Slider editing changed
    func sliderEditingChanged(editing: Bool) {
        if !editing {
            player?.currentTime = sliderValue
        }
    }
    
    // MARK: - Private methods
    
    /// Switch between book chapters
    private func switchChapter(to keyPoint: Int) {
        guard (0..<keyPoints.count).contains(keyPoint) else {
            return
        }
        let keyPointName = keyPoints[currenKeyPointIndex].name
        loadAudio(from: keyPointName)
    }
    
    /// Load key points of the book from JSON
    private func loadKeyPoints(from filename: String) {
        do {
            guard let data = try JSONLoader().loadJSON(from: filename) else {
                isShowingErrorAlert = true
                return
            }
            keyPoints = try JSONDecoder().decode([BookKeyPoint].self, from: data)
        } catch {
            isShowingErrorAlert = true
        }
    }
    
    /// Load audio from a file
    private func loadAudio(from filename: String) {
        do {
            guard let url = try MP3Loader().loadMP3(from: filename) else {
                return
            }
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.enableRate = true
            player.delegate = self
            duration = player.duration
            self.player = player
        } catch {
            
        }
    }
    
    /// Start timer to update slider
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1 / Double(playbackSpeed.rawValue),
            repeats: true
        ) { [weak self] _ in
            self?.updateSliderValue()
            self?.checkIfFinished()
        }
    }
    
    /// Check whether audio is finished
    private func checkIfFinished() {
        guard let player else {
            return
        }
        if player.currentTime >= player.duration {
            stopTimer()
            skipKeyPoint(.forward)
        }
    }
    
    /// Stop timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// Set playback speed
    private func setPlaybackSpeed() {
        player?.rate = playbackSpeed.rawValue
    }
    
    // MARK: - Deinit
    
    deinit {
        stopTimer()
    }
}

// MARK: - AVAudioPlayerDelegate

extension PlayerViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        skipKeyPoint(.forward)
    }
}
