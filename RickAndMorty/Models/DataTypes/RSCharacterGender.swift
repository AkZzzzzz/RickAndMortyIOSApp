//
//  RSCharacterGender.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

enum RSCharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
       
    var text : String {
        switch self {
            case .female, .male, .genderless:
                return rawValue
            case .unknown:
                return "Unknown"
        }
    }
}
