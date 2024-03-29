//
//  SearchViewController.swift
//  SearchExperiment
//
//  Created by Yongyang Nie on 3/22/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var data = [String]()
    
    var sender: UITextField!
    var filteredData: [String]!
    var mainSearchView: SearchView!
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.mainSearchView = SearchView.init(frame: CGRect.init(x: 0, y: 0, width: 768, height: 1024))
        self.view.addSubview(self.mainSearchView)
        
        self.mainSearchView.tableView.delegate = self
        self.mainSearchView.tableView.dataSource = self
        self.mainSearchView.searchBar.delegate = self
        
        filteredData = data
    }
    
    // MARK: - UITableView Delegate
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.sender.text = filteredData[indexPath.row]
        
        self.dismiss(animated: true) {
            self.sender.resignFirstResponder()
        }
    }
    
    // MARK: - Search Bar Delegate
    
    // This method updates filteredData based on the text in the Search Box
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.mainSearchView.tableView.reloadData()
    }
    
}
