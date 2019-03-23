//
//  SearchView.swift
//  SearchExperiment
//
//  Created by Yongyang Nie on 3/22/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit

public class SearchView: UIView {
    
    public var tableView: UITableView!
    public var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 76, width: self.frame.height, height: self.frame.width))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 20, width: self.frame.width, height: 56))
        searchBar.placeholder = "Please Enter a City"
        
        self.addSubview(tableView)
        self.addSubview(searchBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
