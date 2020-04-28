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
import SwiftSpinner

class SearchResultsPageController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var searchResultsTable: UITableView!
    var searchQuery = ""
    let getter = SearchResultsGetter()
    var data = [Any]()
    let bookmarkTrue = UIImage(systemName: "bookmark.fill")
    let bookmarkFalse = UIImage(systemName: "bookmark")
    let defaults = UserDefaults.standard
    var bookmarkArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTable.dataSource = self
        searchResultsTable.delegate = self
        SwiftSpinner.show("Loading Search Results...")
        bookmarkArray = defaults.object(forKey: "bookmarkArray") as? [String] ?? [String]()
        getter.getSearchResults(query: searchQuery, completion: {(data) -> Void in
            self.data = data
            print(data)
            self.searchResultsTable.reloadData()
            SwiftSpinner.hide()
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
        let id = jsonData["id"].stringValue
        cell.id = id
        
        if self.bookmarkArray.firstIndex(of: cell.id) != nil {
            cell.bookmarkButton.setImage(self.bookmarkTrue, for: .normal)
            cell.isBookmarked = true
        } else {
            cell.bookmarkButton.setImage(self.bookmarkFalse, for: .normal)
            cell.isBookmarked = false
        }
        
        cell.bookmarkButtonAction = { [unowned self] in
            if cell.isBookmarked == true {
                cell.isBookmarked = false
                cell.bookmarkButton.setImage(self.bookmarkFalse, for: .normal)
                self.bookmarkArray = self.bookmarkArray.filter {$0 != cell.id}
            } else {
                cell.isBookmarked = true
                cell.bookmarkButton.setImage(self.bookmarkTrue, for: .normal)
                self.bookmarkArray.append(cell.id)
            }
            self.defaults.set(self.bookmarkArray, forKey: "bookmarkArray")
        }
        
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
        cell.searchResultsTableSection.text = jsonData["sectionName"].stringValue
        let formatter = Formatter()
        let dateAgo = formatter.formatTime(time: jsonData["webPublicationDate"].stringValue)
        cell.searchResultsTableTime.text = dateAgo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(self.data[indexPath.row])
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedPageViewController") as! DetailedPageViewController
        let jsonData = JSON(self.data[indexPath.row])
        detailVC.thumbnailData = jsonData["id"].stringValue
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
