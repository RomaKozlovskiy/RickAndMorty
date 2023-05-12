//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
            
        }
    }
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Public Properties
    var result: Result?
    var characterUrl: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        descriptionLabel.textColor = .white
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        NetworkManager.shared.fetchCharacter(from: characterUrl) { result in
            self.result = result
            self.title = result.name
            self.descriptionLabel.text = result.description
            self.characterImageView.fetchImage(from: result.image)
        }
    }
   
    
   

}
