//
//  RSEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import UIKit

final class RSEpisodeViewController: UIViewController, RSEpisodeListViewDelegate {

    private let episodeListView = RSEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Episodes"
        setUpView()
   }
   
    private func setUpView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func rsEpisodeListView(_ characterListView: RSEpisodeListView, didSelectEpisode episode: RSEpisode) {
        let detailVC = RSEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
