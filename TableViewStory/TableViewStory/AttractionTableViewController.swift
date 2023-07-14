//
//  AttractionTableViewController.swift
//  TableViewStory
//
//  Created by james on 27/04/2023.
//

import UIKit

class AttractionTableViewController: UITableViewController {
    
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    var searching = false
    var matches = [Int]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize() {
        attractionNames = ["Buckingham Palace",
                           "The Eiffel Tower",
                           "The Grand Canyon",
                           "Windsor Castle",
                           "Empire State Building"]
        webAddresses = ["https://en.wikipedia.org/wiki/Buckingham_Palace",
                        "https://en.wikipedia.org/wiki/Eiffel_Tower",
                        "https://en.wikipedia.org/wiki/Grand_Canyon",
                        "https://en.wikipedia.org/wiki/Windsor_Castle",
                        "https://en.wikipedia.org/wiki/Empire_State_Building"]
        attractionImages = ["buckingham_palace.jpg",
                            "eiffel_tower.jpg",
                            "grand_canyon.jpg",
                            "windsor_castle.jpg",
                            "empire_state_building.jpg"]
        
        tableView.estimatedRowHeight = 50
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Attractions"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? matches.count : attractionNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell", for: indexPath) as! AttractionTableViewCell
        
        let tableRow = indexPath.row
        
        if searching {
            let attractionMatch = matches[tableRow]
            
            cell.attractionLabel.text = attractionNames[attractionMatch]
            cell.attractionImage.image = UIImage(named: attractionImages[attractionMatch])
        } else {
            cell.attractionLabel.text = attractionNames[tableRow]
            cell.attractionImage.image = UIImage(named: attractionImages[tableRow])
        }
       
        cell.attractionLabel.font = .preferredFont(forTextStyle: .headline)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive,
                               title: "Delete",
                               handler: { [self] action, view, completion in
                                   let row = indexPath.row
                                   
                                   if searching {
                                       let attractionMatch = matches[row]
                                       
                                       attractionNames.remove(at: attractionMatch)
                                       attractionImages.remove(at: attractionMatch)
                                       webAddresses.remove(at: attractionMatch)
                                       
                                       updateSearchResults(for: self.searchController)
                                       
                                   } else {
                                       attractionNames.remove(at: row)
                                       attractionImages.remove(at: row)
                                       webAddresses.remove(at: row)
                                       
                                   }
                                   
                                   completion(true)
                                   tableView.reloadData()
                               })
        ])
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
         guard segue.identifier == "ShowAttractionDetails",
               let row = tableView.indexPathForSelectedRow?.row else {
             return
         }
         
         let detailVC = segue.destination as! AttractionDetailsViewController
         detailVC.webSite = searching ? webAddresses[matches[row]] : webAddresses[row]
     }
     
}

extension AttractionTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
                            !searchText.isEmpty {
            matches.removeAll()
            
            for index in 0..<attractionNames.count {
                if attractionNames[index].lowercased().contains(
                    searchText.lowercased()) {
                    matches.append(index)
                }
            }
            
            searching = true
            
        } else {
            searching = false
        }
        
        tableView.reloadData()
    }
    
    
}

extension AttractionTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
    }
}
