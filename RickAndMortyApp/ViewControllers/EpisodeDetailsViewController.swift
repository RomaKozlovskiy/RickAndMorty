//
//  EpisodeDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var episodeDescriptionLabel: UILabel!
    
    // MARK: - Public Properties
    var episodeUrl: String!
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )

        NetworkManager.shared.fetchEpisode(from: episodeUrl) { episode in
            self.episode = episode
            self.title = episode.episode
            self.episodeDescriptionLabel.text = episode.description
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterDetailsVC = segue.destination as? CharacterDetailsViewController else { return }
        characterDetailsVC.characterUrl = sender as? String
    }
}

// MARK: - UITableViewDataSource
extension EpisodeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = episode?.characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterUrl", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = character
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EpisodeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let characterUrl = episode?.characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: characterUrl)
    }
}

