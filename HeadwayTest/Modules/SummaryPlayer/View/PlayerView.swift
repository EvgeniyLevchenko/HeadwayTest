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
        enum Layout {
            static let coverCornerRadius: CGFloat = 10
            static let coverHeight: CGFloat = 335
            static let coverPadding: CGFloat = 40
            static let keyPointTextPadding: CGFloat = 5
            static let desciptionTextPadding: CGFloat = 5
            static let viewsPadding: CGFloat = 50
            static let verticalStackPadding: CGFloat = 20
        }
    }
    
    // MARK: - Properties
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Image(systemName: "doc.text.image")
                        .resizable()
                        .cornerRadius(Constants.Layout.coverCornerRadius)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.Layout.coverHeight)
                        .padding(
                            .horizontal,
                            Constants.Layout.coverPadding
                        )
                    
                    Text("KEY POINT 2 OF 10")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(
                            .top,
                            Constants.Layout.keyPointTextPadding
                        )
                    
                    Text("Design is not how a thing looks, but how it works")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(
                            .top,
                            Constants.Layout.desciptionTextPadding
                        )
                    
                    PlayerProgressBar()
                    PlaybackSpeedView()
                    PlaybackView()
                        .padding(
                            .top,
                            Constants.Layout.viewsPadding
                        )
                    PlayerSwitcherView()
                        .padding(
                            .top,
                            Constants.Layout.viewsPadding
                        )
                }               
            }
            .padding(Constants.Layout.verticalStackPadding)
        }
        .background(Color.mainBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
