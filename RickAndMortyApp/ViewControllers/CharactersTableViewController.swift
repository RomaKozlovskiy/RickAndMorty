//
//  CharactersTableViewController.swift
//  RickAndMortyApp
//
//  Created by Роман Козловский on 07.05.2023.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var rickAndMorty: RickAndMorty?
    private var filteredCharacters: [Result] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        
        setupSearchController()
        setupNavigationBar()
        fetchData(from: URLS.rickAndMortyApi.rawValue)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering
        ? filteredCharacters.count
        : rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = isFiltering
        ? filteredCharacters[indexPath.row]
        : rickAndMorty?.results[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.setupWith(result: character)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
    
        let character = isFiltering
        ? filteredCharacters[indexPath.row]
        : rickAndMorty?.results[indexPath.row]
        
        guard let charDetailVC = segue.destination as? CharacterDetailsViewController else { return }
        charDetailVC.characterUrl = character?.url
    }
    
    // MARK: - IB Action
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: rickAndMorty?.info.next)
        : fetchData(from: rickAndMorty?.info.prev)
    }
    
    // MARK: - Private Methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = .systemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.tableView.reloadData()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchTExt(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchTExt(_ searchText: String) {
        filteredCharacters = rickAndMorty?.results.filter({ character in
            character.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        
        tableView.reloadData()
    }
}
