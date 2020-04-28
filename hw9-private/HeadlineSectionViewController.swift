//
//  HeadlineSectionViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/26/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import SwiftSpinner
import SwiftyJSON

class HeadlineSectionViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DetailedPageDelegate {
    
    
    @IBOutlet weak var headlineSectionTable: UITableView!
    
    let getter = HeadlineSectionGetter()
    var section = ""
    var data = [Any]()
    let bookmarkTrue = UIImage(systemName: "bookmark.fill")
    let bookmarkFalse = UIImage(systemName: "bookmark")
    let defaults = UserDefaults.standard
    var bookmarkArray = [String]()
    
    override func viewDidLoad() {
        let sectionName = self.section.uppercased()
        SwiftSpinner.show("Loading \(sectionName) Headlines...")
        super.viewDidLoad()
        
        headlineSectionTable.dataSource = self
        headlineSectionTable.delegate = self
        headlineSectionTable.rowHeight = 110
        
        bookmarkArray = defaults.object(forKey: "bookmarkArray") as? [String] ?? [String]()
        
        var sect = ""
        if self.section == "sports" {
            sect = "sport"
        } else {
            sect = self.section
        }
        
        getter.getHeadlineResults(section: sect, completion: {(data) -> Void in
            self.data = data
            self.headlineSectionTable.reloadData()
            SwiftSpinner.hide()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headlineSectionTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func toggleBookmark(id: String) {
        if self.bookmarkArray.firstIndex(of: id) != nil {
            self.bookmarkArray = self.bookmarkArray.filter{$0 != id}
        } else {
            self.bookmarkArray.append(id)
        }
        defaults.set(self.bookmarkArray, forKey: "bookmarkArray")
        self.headlineSectionTable.reloadData()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.section.uppercased())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineSectionCell", for: indexPath) as! HeadlineSectionCell
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
            let bkArr = self.defaults.object(forKey: "bookmarkArray") as? [String] ?? [String]()
            if bkArr.firstIndex(of: cell.id) != nil {
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
        
        let thumbUrl = URL(string: jsonData["img"].stringValue)
        cell.headlineSectionImg?.kf.setImage(with: thumbUrl, placeholder: UIImage(named: "default-guardian"))
        cell.headlineSectionTitle.text = jsonData["title"].stringValue
        cell.headlineSectionSection.text = jsonData["section"].stringValue
        cell.headlineSectionDate.text = jsonData["date"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.data[indexPath.row])
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedPageViewController") as! DetailedPageViewController
        detailVC.delegate = self
        let jsonData = JSON(self.data[indexPath.row])
        detailVC.thumbnailData = jsonData["id"].stringValue
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

