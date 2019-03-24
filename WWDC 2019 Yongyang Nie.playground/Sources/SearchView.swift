//
//  SearchView.swift
//  SearchExperiment
//
//  Created by Yongyang Nie on 3/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit

public class SearchView: UIView {
    
    public var tableView: UITableView!
    public var searchBar: UISearchBar!
    public var dismissButton : UIButton!
    // initialize all UI elements
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 76, width: self.frame.height, height: self.frame.width))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        searchBar = UISearchBar.init(frame: CGRect.init(x: 95, y: 20, width: self.frame.width - 95, height: 56))
        searchBar.placeholder = "Please Enter a City"
        
        dismissButton = UIButton.init(frame: CGRect.init(x: 6, y: 20, width: 85, height: 56))
        dismissButton.setTitle("Dismiss", for: UIControl.State.normal)
        dismissButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        
        self.addSubview(dismissButton)
        self.addSubview(tableView)
        self.addSubview(searchBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
