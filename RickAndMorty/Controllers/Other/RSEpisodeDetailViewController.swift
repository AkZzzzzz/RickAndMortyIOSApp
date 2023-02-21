//
//  RSEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 21.02.2023.
//

import UIKit

final class RSEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }

}
