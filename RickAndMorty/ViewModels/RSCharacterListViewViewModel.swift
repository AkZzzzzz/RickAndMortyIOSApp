//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 07.02.2023.
//

import UIKit

final class RSCharacterListViewViewModel: NSObject {
    func fetchCharacter() {
        RSService.share.execute(.listCharactersRequest, expecting: RSGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Example image url: "+String(model.results.first?.image ?? "NO IMAGE"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RSCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RSCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RSCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = RSCharacterCollectionViewCellViewModel(
            characterName: "Artem",
            characterStatus: .Alive,
            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        cell.configure(with: viewModel)
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
