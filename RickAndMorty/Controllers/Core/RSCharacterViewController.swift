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
        
        RSService.share.execute(.listCharactersRequest, expecting: RSGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.count))
                print("Paage result count: "+String(model.results.count))

            case .failure(let error):
                print(String(describing: error))
            }
        }
   }
   
}
