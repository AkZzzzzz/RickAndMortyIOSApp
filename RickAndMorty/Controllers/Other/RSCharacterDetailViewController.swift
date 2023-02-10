//
//  RSCharcterDetailViewController.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 10.02.2023.
//

import UIKit

final class RSCharacterDetailViewController: UIViewController {
    
    private let viewModel: RSCharacterDetailViewViewModel
    
    init(viewModel: RSCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
