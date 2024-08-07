//
//  PlayerView.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 05.08.2024.
//

import SwiftUI

// MARK: - PlayerView

struct PlayerView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        
        enum Image {
            static let bookCoverImageName: String = "bookCover"
        }
        
        enum Text {
            static let keyPointText: String = "KEY POINT %d OF %d"
            static let durationText: String = "%d:%02d"
            static let bookDescriptionText: String = "To conquer fear is the beginning of wisdom"
            static let playbackErrorTitle: String = "Playback Error"
            static let playbackErrorMessage: String = "An error occurred while trying to play the audio. Please try again."
            static let alertButtonTitle: String = "Try againg"
        }
        
        enum Format {
            static let secondsInMinute: Int = 60
        }
        
        enum Layout {
            static let switcherViewPadding: CGFloat = 60
            static let coverCornerRadius: CGFloat = 10
            static let coverHeight: CGFloat = 335
            static let coverHorizontalPadding: CGFloat = 40
            static let coverTopPadding: CGFloat = 50
            static let textPadding: CGFloat = 5
            static let viewsPadding: CGFloat = 40
            static let playbackViewBottomPadding: CGFloat = 130
            static let verticalStackPadding: CGFloat = 20
        }
    }
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = PlayerViewModel()
    
    // MARK: - Properties
    
    var body: some View {
        ZStack {
            PlayerSwitcherView(isPlayerOpen: $viewModel.isPlayerOpen)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottom
                )
                .padding(
                    .bottom,
                    Constants.Layout.switcherViewPadding
                )
            
            VStack {
                Spacer()
                VStack {
                    Image(
                        Constants.Image.bookCoverImageName
                    )
                    .resizable()
                    .cornerRadius(Constants.Layout.coverCornerRadius)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.Layout.coverHeight)
                    .padding(
                        .horizontal,
                        Constants.Layout.coverHorizontalPadding
                    )
                    .padding(
                        .top,
                        Constants.Layout.coverTopPadding
                    )
                    
                    Text(
                        String(
                            format: Constants.Text.keyPointText,
                            viewModel.currenKeyPointIndex + 1,
                            viewModel.keyPoints.count
                        )
                    )
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(
                        .top,
                        Constants.Layout.viewsPadding
                    )
                    
                    Text(Constants.Text.bookDescriptionText)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(
                            .top,
                            Constants.Layout.textPadding
                        )
                    
                    Slider(
                        value: $viewModel.sliderValue,
                        in: 0...viewModel.duration,
                        label: { },
                        minimumValueLabel: {
                            Text(formatTime(viewModel.sliderValue))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        },
                        maximumValueLabel: {
                            Text(formatTime(viewModel.duration))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        },
                        onEditingChanged: { editing in
                            viewModel.sliderEditingChanged(editing: editing)
                        }
                    )
                    
                    PlaybackSpeedView(playbackSpeed: $viewModel.playbackSpeed)
                    
                    PlaybackView(
                        backwardAction: {
                            viewModel.skipKeyPoint(.backward)
                        },
                        rewindBackAction: {
                            viewModel.rewind()
                        },
                        playPauseAction: {
                            viewModel.playPause()
                        },
                        fastForwardAction: {
                            viewModel.fastForward()
                        },
                        forwardAction: {
                            viewModel.skipKeyPoint(.forward)
                        }
                    )
                    .padding(
                        .top,
                        Constants.Layout.viewsPadding
                    )
                    .padding(
                        .bottom,
                        Constants.Layout.playbackViewBottomPadding
                    )
                    
                }
            }
            .opacity(viewModel.isPlayerOpen ? 1 : 0)
            .padding(Constants.Layout.verticalStackPadding)
        }
        .background(Color.mainBackground)
        .onAppear {
            viewModel.start()
        }
        .alert(
            Constants.Text.playbackErrorTitle,
            isPresented: $viewModel.isShowingErrorAlert
        ) {
            Button(Constants.Text.alertButtonTitle, role: .cancel) {
                viewModel.start()
            }
        } message: {
            Text(Constants.Text.playbackErrorMessage)
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / Constants.Format.secondsInMinute
        let seconds = Int(time) % Constants.Format.secondsInMinute
        return String(
            format: Constants.Text.durationText,
            minutes, seconds
        )
    }
}

// MARK: - PlayerView Preview

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
