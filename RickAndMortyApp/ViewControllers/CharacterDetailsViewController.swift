//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Public Properties
    var result: Result?
    var characterUrl: String!
    
    // MARK: - Private Properties
    private var spinnerView: UIActivityIndicatorView!

    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerView = showSpinner(in: view)
        
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
            self.spinnerView.stopAnimating()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let episodesVC = navigationVC.topViewController as? EpisodesViewController else { return }
        episodesVC.result = result
    }
    
    // MARK: - Private Methods
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
