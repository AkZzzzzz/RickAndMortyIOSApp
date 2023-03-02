//
//  RSEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 27.02.2023.
//

import UIKit

protocol RSEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    
    func didSelectEpisode(_ episode: RSEpisode)
}
//View Model to handle character list view logic
final class RSEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RSEpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var episodes: [RSEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RSCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: episode.url))
                if !cellViewModels.contains(viewModel) {
                    
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RSCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RSGetAllEpisodesResponse.Info? = nil
    
    public func fetchEpisodes() {
        RSService.share.execute(
            .listEpisodesRequest,
            expecting: RSGetAllEpisodesResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.episodes = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCEpisodes(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = RSRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        RSService.share.execute(request, expecting: RSGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.episodes.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.episodes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(
                        with: indexPathToAdd
                    )
                   strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false

            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
    
}

//MARK: - CollectionView

extension RSEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RSCharacterEpisodeCollectionViewCell.cellIdentifer,
            for: indexPath
        ) as? RSCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RSFooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? RSFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 0.8
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selection = episodes[indexPath.row]
        delegate?.didSelectEpisode(selection)
    }
    
}

//MARK: - Scroll View

extension RSEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeihgt = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeihgt - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}
