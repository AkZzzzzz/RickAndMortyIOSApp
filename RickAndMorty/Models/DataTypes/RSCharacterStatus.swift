//
//  RSCharacterStatus.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

enum RSCharacterStatus: String, Codable {
    
    case Alive = "Alive"
    case Dead = "Dead"
    case `unknown` = "unknown"
       
    var text : String {
        switch self {
            case .Alive, .Dead:
                return rawValue
            case .unknown:
                return "Unknown"
        }
    }
}
