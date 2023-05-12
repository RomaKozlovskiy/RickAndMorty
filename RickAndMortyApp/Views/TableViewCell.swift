//
//  TableViewCell.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    func setupWith(result: Result?) {
        nameLabel.text = result?.name
        characterImageView.fetchImage(from: result?.image ?? "")
    }
   

}
