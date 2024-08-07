//
//  PlaybackView.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 05.08.2024.
//

import SwiftUI

struct PlaybackView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Images {
            static let backwardEnd: String = "backward.end.fill"
            static let goBackward: String = "gobackward.5"
            static let pause: String = "pause.fill"
            static let play: String = "play.fill"
            static let goForward: String = "goforward.10"
            static let forwardEnd: String = "forward.end.fill"
        }
        
        enum Layout {
            static let horizonatlStackSpacing: CGFloat = 35
            static let changePointButtonSize: CGFloat = 20
            static let forwardBackwardButtonWidth: CGFloat = 28
            static let forwardBackwardButtonHeight: CGFloat = 32
            static let pausePlayButtonWidth: CGFloat = 30
            static let pausePlayButtonHeight: CGFloat = 34
        }
    }
    
    // MARK: - Private properties
    
    @State private var isPlaying: Bool = false
    private let backwardAction: (() -> Void)?
    private let rewindBackAction: (() -> Void)?
    private let playPauseAction: (() -> Void)?
    private let fastForwardAction: (() -> Void)?
    private let forwardAction: (() -> Void)?
    
    // MARK: - Init
    
    init(
        backwardAction: (() -> Void)? = nil,
        rewindBackAction: (() -> Void)? = nil,
        playPauseAction: (() -> Void)? = nil,
        fastForwardAction: (() -> Void)? = nil,
        forwardAction: (() -> Void)? = nil
    ) {
        self.backwardAction = backwardAction
        self.rewindBackAction = rewindBackAction
        self.playPauseAction = playPauseAction
        self.fastForwardAction = fastForwardAction
        self.forwardAction = forwardAction
    }
    
    // MARK: - Properties
    
    var body: some View {
        
        // Playback controls
        HStack(spacing: Constants.Layout.horizonatlStackSpacing) {
            Button(action: {
                backwardAction?()
                isPlaying = false
            }) {
                Image(systemName: Constants.Images.backwardEnd)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(
                        width: Constants.Layout.changePointButtonSize,
                        height: Constants.Layout.changePointButtonSize
                    )
            }
            
            Button(action: {
                rewindBackAction?()
            }) {
                Image(systemName: Constants.Images.goBackward)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(
                        width: Constants.Layout.forwardBackwardButtonWidth,
                        height: Constants.Layout.forwardBackwardButtonHeight
                    )
            }
            
            Button(action: {
                isPlaying.toggle()
                playPauseAction?()
            }) {
                Image(systemName:
                        isPlaying
                      ? Constants.Images.play
                      : Constants.Images.pause
                )
                .resizable()
                .foregroundColor(.black)
                .frame(
                    width: Constants.Layout.pausePlayButtonWidth,
                    height: Constants.Layout.pausePlayButtonHeight
                )
            }
            
            Button(action: {
                fastForwardAction?()
            }) {
                Image(systemName: Constants.Images.goForward)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(
                        width: Constants.Layout.forwardBackwardButtonWidth,
                        height: Constants.Layout.forwardBackwardButtonHeight
                    )
            }
            
            Button(action: {
                forwardAction?()
                isPlaying = false
            }) {
                Image(systemName: Constants.Images.forwardEnd)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(
                        width: Constants.Layout.changePointButtonSize,
                        height: Constants.Layout.changePointButtonSize
                    )
            }
        }
    }
}
