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
import Alamofire

protocol submitSearch {
    func submitSearch(query: String)
}

class SearchViewController: UITableViewController {
    
    let searchBar = UISearchBar()
    var data = [String]()
    var delegate: submitSearch?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchResultCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    func setUpNavBar() {
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
    
    func autosuggest(query: String) -> Void {
        self.data = [String]()
        let url = "https://api.cognitive.microsoft.com/bing/v7.0/suggestions?q=\(query)"
        let headers: HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": "",//YOUR API KEY HERE
          "Accept": "application/json"
        ]
        Alamofire.request(url, headers: headers)
            .responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let suggestionArr = swiftyJsonVar["suggestionGroups"][0]["searchSuggestions"]
                if suggestionArr.count > 0 {
                    for i in 0...suggestionArr.count - 1 {
                        let cur = JSON(suggestionArr[i])
                        let str = cur["displayText"].stringValue
                        self.data.append(str)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        //cell.textLabel?.text = "HI"
        let word = self.data[indexPath.item]
        
        cell.textLabel?.text = word
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = self.data[indexPath.item]
        self.delegate?.submitSearch(query: self.data[indexPath.item])
    }
}
