//
//  SearchResultsPageController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/25/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SearchResultsPageController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var searchResultsTable: UITableView!
    var searchQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTable.dataSource = self
        searchResultsTable.delegate = self
        searchResultsTable.reloadData()
        print("in searchresults page controller" )
        print(searchQuery)
        searchUrl = searchUrl + searchQuery
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchResultsTable.reloadData()
        self.header.text = "Search Results"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath) as! SearchResultsTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
