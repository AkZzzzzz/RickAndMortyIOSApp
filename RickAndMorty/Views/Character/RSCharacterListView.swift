//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 07.02.2023.
//

import UIKit

protocol RSCharacterListViewDelegate: AnyObject {
    func rsCharacterListView(
        _ characterListView: RSCharacterListView,
        didSelectCharacter character: RSCharacter
    )
}

final class RSCharacterListView: UIView {
    
    public weak var delegate: RSCharacterListViewDelegate?
    
    private let viewModel = RSCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RSCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: RSCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(RSFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RSFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        addConstraint()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacter()
        setUpCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension RSCharacterListView: RSCharacterListViewViewModelDelegate {
    func didSelectCharacter(_ character: RSCharacter) {
        delegate?.rsCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
        collectionView.reloadData()
        spinner.stopAnimating()
            
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
            }
    }
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}
