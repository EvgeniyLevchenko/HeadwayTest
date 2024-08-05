//
//  PlayerProgressBar.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 05.08.2024.
//

import SwiftUI

// MARK: - PlayerProgressBar

struct PlayerProgressBar: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let height: CGFloat = 5
        static let padding: CGFloat = 10
    }
    
    // MARK: - Properties
    
    var body: some View {
        HStack {
            Text("00:28")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ProgressView(value: 28, total: 132)
                .progressViewStyle(
                    LinearProgressViewStyle(tint: .blue)
                )
                .frame(height: Constants.height)
                .padding(
                    .horizontal,
                    Constants.padding
                )
            
            Text("02:12")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(
            .top, Constants.padding
        )
    }
}

