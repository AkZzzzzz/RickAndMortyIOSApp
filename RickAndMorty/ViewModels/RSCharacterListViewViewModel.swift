//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 07.02.2023.
//

import UIKit

protocol RSCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class RSCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RSCharacterListViewViewModelDelegate?
    
    private var characters: [RSCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RSCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RSCharacterCollectionViewCellViewModel] = []
    
    public func fetchCharacter() {
        RSService.share.execute(
            .listCharactersRequest,
            expecting: RSGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RSCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RSCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RSCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}

