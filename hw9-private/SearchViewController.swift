//
//  SearchViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/25/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import os.log
import SwiftyJSON
import CoreLocation
import MapKit
import Kingfisher

class SearchViewController: UITableViewController {
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
        self.resignFirstResponder()
        self.dismiss(animated: true)
    }
    
    func setUpNavBar() {
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
}
