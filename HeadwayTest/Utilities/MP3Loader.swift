//
//  MP3Loader.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 06.08.2024.
//

import Foundation

final class MP3Loader {
    
    // MARK: - Constants
    
    private enum Constants {
        static let mp3Extension: String = "mp3"
    }
    
    // MARK: - Methods

    func loadMP3(from filename: String) throws -> URL? {
        guard let url = Bundle.main.url(
            forResource: filename,
            withExtension: Constants.mp3Extension
        ) else {
            return nil
        }
        return url
    }
}
