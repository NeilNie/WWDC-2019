//
//  SearchViewController.swift
//  SearchExperiment
//
//  Created by Yongyang Nie on 3/22/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var data = [String]()
    
    var sender: UITextField!
    var filteredData: [String]!
    var mainSearchView: SearchView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.mainSearchView = SearchView.init(frame: self.view.frame)
        self.view.addSubview(self.mainSearchView)
        
        self.mainSearchView.tableView.delegate = self
        self.mainSearchView.tableView.dataSource = self
        self.mainSearchView.searchBar.delegate = self
        
        filteredData = data
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sender.text = filteredData[indexPath.row]
        
        self.dismiss(animated: true) {
            print("view dismissed")
        }
    }
    
    // MARK: - Search Bar Delegate
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.mainSearchView.tableView.reloadData()
    }
    
}
