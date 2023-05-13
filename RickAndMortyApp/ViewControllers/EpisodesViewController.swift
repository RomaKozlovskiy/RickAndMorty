//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class EpisodesViewController: UITableViewController {

    // MARK: - Public Properties
    var result: Result!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )

        tableView.rowHeight = 70
        
        setupNavigationBar()
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result.episode.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = result.episode[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = episode
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeUrl = result.episode[indexPath.row]
        performSegue(withIdentifier: "showEpisode", sender: episodeUrl)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetailsVC = segue.destination as? EpisodeDetailsViewController else { return }
        episodeDetailsVC.episodeUrl = sender as? String
    }

    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Episodes"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 0.7
        )
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
}
