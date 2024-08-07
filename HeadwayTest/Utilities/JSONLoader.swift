//
//  JSONLoader.swift
//  HeadwayTest
//
//  Created by Yevhenii Levchenko on 06.08.2024.
//

import Foundation

final class JSONLoader {
    
    // MARK: - Constants
    
    private enum Constants {
        static let jsonExtension: String = "json"
    }
    
    // MARK: - Methods
    
    func loadJSON(from filename: String) throws -> Data? {
        guard let url = Bundle.main.url(
            forResource: filename,
            withExtension: Constants.jsonExtension
        ) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw(error)
        }
    }
}
