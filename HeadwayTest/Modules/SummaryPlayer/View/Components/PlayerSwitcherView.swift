//
//  PlayerSwitcherView.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 05.08.2024.
//

import SwiftUI

struct PlayerSwitcherView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        enum Image {
            static let textAlignLeft: String = "text.alignleft"
            static let headphones: String = "headphones"
        }
        
        enum Layout {
            static let cornerRadius: CGFloat = 30
            static let rectangleWidth: CGFloat = 140
            static let rectangleHeight: CGFloat = 60
            static let circleSize: CGFloat = 50
            static let circleOffset: CGFloat = 38.5
            static let imageSize: CGFloat = 20
            static let buttonWidth: CGFloat = 70
            static let buttonHeight: CGFloat = 60
        }
    }
    
    // MARK: - Properties
    
    @Binding var isPlayerOpen: Bool
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(
                    cornerRadius: Constants.Layout.cornerRadius
                )
                .fill(.white)
                .frame(
                    width: Constants.Layout.rectangleWidth,
                    height: Constants.Layout.rectangleHeight
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.Layout.rectangleHeight / 2)
                            .stroke(Color.customGray, lineWidth: 1)
                )
                
                Circle()
                    .fill(Color.blue)
                    .frame(
                        width: Constants.Layout.circleSize,
                        height: Constants.Layout.circleSize
                    )
                    .offset(
                        x: isPlayerOpen
                        ? Constants.Layout.circleOffset
                        : -Constants.Layout.circleOffset
                    )
                
                HStack {
                    Button(action: {
                        withAnimation {
                            isPlayerOpen = false
                        }
                    }) {
                        Image(systemName: Constants.Image.textAlignLeft)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: Constants.Layout.imageSize,
                                height: Constants.Layout.imageSize
                            )
                            .padding()
                            .foregroundColor(isPlayerOpen ? .black : .white)
                    }
                    .frame(
                        width: Constants.Layout.buttonWidth,
                        height: Constants.Layout.buttonHeight
                    )
                    
                    Button(action: {
                        withAnimation {
                            isPlayerOpen = true
                        }
                    }) {
                        Image(systemName: Constants.Image.headphones)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: Constants.Layout.imageSize,
                                height: Constants.Layout.imageSize
                            )
                            .padding()
                            .foregroundColor(isPlayerOpen ? .white : .black)
                    }
                    .frame(
                        width: Constants.Layout.buttonWidth,
                        height: Constants.Layout.buttonHeight
                    )
                }
            }
        }
    }
}
