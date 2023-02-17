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
    
    private let pathComponents: [String]
    
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
    
    public init(endpoint: RSEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rsEndpoint = RSEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rsEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let rsEndpoint = RSEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rsEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
    
}

extension RSRequest {
    static let listCharactersRequest = RSRequest(endpoint: .character)
}
