//
//  RSCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 18.02.2023.
//

import UIKit

final class RSCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        //Format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        //Format
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None" }
        
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
           return Self.shortDateFormatter.string(from: date)
       }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemRed
            case .gender:
                return .systemGreen
            case .type:
                return .systemOrange
            case .species:
                return .systemBlue
            case .origin:
                return .systemPink
            case .location:
                return .systemCyan
            case .created:
                return .systemGray
            case .episodeCount:
                return .systemPurple
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                    .gender,
                    .type,
                    .species,
                    .origin,
                    .location,
                    .created:
                    return rawValue.uppercased()
                   case .episodeCount:
                        return "EPISODE COUNT"
            }
        }
    }
    
    init(
        type: `Type`, value: String
    ) {
        self.value = value
        self.type = type
    }
}
