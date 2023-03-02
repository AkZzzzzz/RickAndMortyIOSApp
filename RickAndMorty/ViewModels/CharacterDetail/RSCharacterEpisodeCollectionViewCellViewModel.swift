//
//  RSCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 18.02.2023.
//

import Foundation

protocol RSEpisodeDataRender{
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }

}

final class RSCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {
    
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((RSEpisodeDataRender) -> Void)?
    
    private var episode: RSEpisode? {
        didSet{
            guard let model = episode else {
                return
            }
            dataBlock?(model)
            
        }
    }
    
    //MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    //MARK: - Public
    
    public func registerForData(_ block: @escaping (RSEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl, let request = RSRequest(url: url) else {
            return
        }
        isFetching = true
        
        RSService.share.execute(request, expecting: RSEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))

            }
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: RSCharacterEpisodeCollectionViewCellViewModel, rhs: RSCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
