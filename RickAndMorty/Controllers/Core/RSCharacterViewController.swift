//
//  RSCharcterViewController.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 06.02.2023.
//

import UIKit

final class RSCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RSRequest(endpoint: .character, pathComponents: [], queryParameters: [
            URLQueryItem(name: "name", value: "rick"),
            URLQueryItem(name: "status", value: "alive")
        ])
        
        print(request.url)
        
        RSService.share.execute(request, expecting: RSCharacter.self) { result in
        
        }
   }
    
    
}
