//
//  RSGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 01.03.2023.
//

import Foundation

struct RSGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RSEpisode]
}
