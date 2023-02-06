//
//  RSRequest.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import Foundation

///
final class RSRequest {
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    private let endpoint: RSEndpoint
    
    private let pathComponents: Set<String>
    
    private let queryParameters: [URLQueryItem]
    
    private var uslString: String {
        var customString = Constants.baseUrl
        customString += "/"
        customString += endpoint.rawValue
                
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                customString += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            customString += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            customString += argumentString
        }
        return customString
    }
    
    public var url: URL? {
        return URL(string: uslString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: RSEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
