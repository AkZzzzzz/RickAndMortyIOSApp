//
//  RSAPICacheManager.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 27.02.2023.
//

import Foundation

final class RSAPICacheManager {
    
    private var cacheDictionary: [RSEndpoint: NSCache<NSString, NSData>] = [:]
        
    init() {
        setUpCache()
    }
    
    public func cachedResponse(for endpoint: RSEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RSEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setUpCache() {
        RSEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
