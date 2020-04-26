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
import Kingfisher

class SearchResultsPageController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var searchResultsTable: UITableView!
    var searchQuery = ""
    let getter = SearchResultsGetter()
    var data = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTable.dataSource = self
        searchResultsTable.delegate = self
        
        print("in searchresults page controller" )
        print(searchQuery)
        getter.getSearchResults(query: searchQuery, completion: {(data) -> Void in
            self.data = data
            print(data)
            self.searchResultsTable.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchResultsTable.reloadData()
        self.header.text = "Search Results"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath) as! SearchResultsTableCell
        let jsonData = JSON(self.data[indexPath.item])
        if let imgArr = jsonData["blocks"]["main"]["elements"][0]["assets"].array {
            if imgArr.count > 0 {
                let jsonImg = JSON(imgArr[imgArr.count - 1])
                let url = URL(string: jsonImg["file"].stringValue)
                cell.searchResultsTableImg?.kf.setImage(with: url)
            } else {
                cell.searchResultsTableImg.kf.setImage(with: URL(string: "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"))
            }
        }
        else {
            cell.searchResultsTableImg.kf.setImage(with: URL(string: "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"))
        }
        cell.searchResultsTableTitle.text = jsonData["webTitle"].stringValue
        cell.searchResultsTableSection.text = jsonData["sectionId"].stringValue
        cell.searchResultsTableTime.text = jsonData["webPublicationDate"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}
