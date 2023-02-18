//
//  RSCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Артём Козловский on 18.02.2023.
//

import UIKit

final class RSCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RSCharacterEpisodeCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RSCharacterEpisodeCollectionViewCellViewModel) {
        
    }
}
