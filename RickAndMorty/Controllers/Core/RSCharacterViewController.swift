//
//  RSCharcterViewController.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import UIKit

final class RSCharacterViewController: UIViewController, RSCharacterListViewDelegate {
    
    private let characterListView = RSCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
   }
   
    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func rsCharacterListView(_ characterListView: RSCharacterListView, didSelectCharacter character: RSCharacter) {
        let viewModel = RSCharacterDetailViewViewModel(character: character)
        let detailVC = RSCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
