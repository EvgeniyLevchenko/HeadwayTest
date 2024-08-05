//
//  PlaybackSpeedView.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 05.08.2024.
//

import SwiftUI

// MARK: - PlaybackSpeedView

struct PlaybackSpeedView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Text {
            static let speedText: String = "Speed"
        }
        
        enum Layout {
            static let verticalPadding: CGFloat = 5
            static let horizontalPadding: CGFloat = 10
            static let cornerRadius: CGFloat = 10
            static let buttonPadding: CGFloat = 20
        }
    }
    
    // MARK: - PlaybackSpeed
    
    private enum PlaybackSpeed: Double, CaseIterable {
        case x0_5 = 0.5
        case x0_75 = 0.75
        case x1 = 1.0
        case x1_25 = 1.25
        case x1_5 = 1.5
        case x1_75 = 1.75
        case x2 = 2.0
        
        var displayName: String {
            switch self {
            case .x0_5:
                return "x0.5"
            case .x0_75:
                return "x0.75"
            case .x1:
                return "x1"
            case .x1_25:
                return "x1.25"
            case .x1_5:
                return "x1.5"
            case .x1_75:
                return "x1.75"
            case .x2:
                return "x2"
            }
        }
    }
    
    // MARK: - Private properties
    
    @State private var playbackSpeed: PlaybackSpeed = .x1
    
    // MARK: - Properties
    
    var body: some View {
        Button(action: {
            speedButtonTapped()
        }) {
            Text(Constants.Text.speedText + " \(playbackSpeed.displayName)")
                .font(.body)
                .foregroundColor(.black)
                .padding(
                    .vertical,
                    Constants.Layout.verticalPadding
                )
                .padding(
                    .horizontal,
                    Constants.Layout.horizontalPadding
                )
                .background(Color(UIColor.systemGray5))
                .cornerRadius(Constants.Layout.cornerRadius)
        }
        .padding(
            .top,
            Constants.Layout.buttonPadding
        )
    }
    
    private func speedButtonTapped() {
        let allCases = PlaybackSpeed.allCases
        guard
            let currentSpeedIndex = allCases.firstIndex(where: { $0 == playbackSpeed }),
            (0..<allCases.count).contains(currentSpeedIndex + 1)
        else {
            playbackSpeed = .x0_5
            return
        }
        playbackSpeed = allCases[currentSpeedIndex + 1]
    }
}
