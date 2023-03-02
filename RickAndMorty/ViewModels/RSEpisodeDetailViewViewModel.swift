//
//  RSEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 27.02.2023.
//

import UIKit

final class RSEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init (endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl,
            let request = RSRequest(url: url) else {
            return
        }
        RSService.share.execute(request,
                                expecting: RSEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure:
                break
            }
        }
    }
}
