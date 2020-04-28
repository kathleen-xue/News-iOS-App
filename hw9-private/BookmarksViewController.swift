//
//  BookmarksViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/27/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Kingfisher
import SwiftSpinner

class BookmarksViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DetailedPageDelegate {
    
    @IBOutlet weak var bookmarksCollection: UICollectionView!
    let getter = DetailedNewsGetter()
    let defaults = UserDefaults.standard
    var bookmarkArray = [String]()
    var data = [[String: String]]()
    
    let sectionInsets = UIEdgeInsets(top: 50.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0)
    let itemsPerRow = CGFloat(2)
    
    override func viewDidLoad() {
        SwiftSpinner.show("Loading Bookmarks...")
        super.viewDidLoad()
        bookmarksCollection.dataSource = self
        bookmarksCollection.delegate = self
        self.bookmarkArray = defaults.object(forKey: "bookmarkArray") as? [String] ?? [String]()
        //print(self.bookmarkArray)
        if self.bookmarkArray.count > 0 {
            self.data = [[String: String]]()
            self.getter.getDetailedNewsBulk(idArr: self.bookmarkArray, completion: {(d) -> Void in
                print(d)
                if d.count > 0 {
                    for i in 0...d.count - 1 {
                        let jsonData = JSON(d[i])
                        let image = jsonData["image"].string ?? "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"
                        let title = jsonData["title"].stringValue
                        let section = jsonData["section"].stringValue
                        let date = jsonData["date"].stringValue
                        let id = self.bookmarkArray[i]
                        self.data.append(["image": image, "title": title, "section": section, "date": date, "id": id])
                    }
                    SwiftSpinner.hide()
                }
                
            })
        }
        //SwiftSpinner.hide()
        //print(self.data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SwiftSpinner.show("Loading Bookmarks...")
        super.viewWillAppear(animated)
        SwiftSpinner.hide()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookmarkArray.count
    }
    
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
      return CGSize(width: widthPerItem, height: widthPerItem)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 250)
    }
    
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }*/
    
    /*func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookmarksCell", for: indexPath) as! BookmarksViewCell
        getter.getDetailedNews(id: self.bookmarkArray[indexPath.row], completion: {(data) -> Void in
            let cellData = JSON(data)
            cell.bookmarksTitle.text = cellData["title"].stringValue
            cell.bookmarksDate.text = cellData["date"].stringValue
            let imgurl = URL(string: cellData["image"].stringValue)
            cell.bookmarksImg?.kf.setImage(with: imgurl)
            cell.bookmarksSection.text = cellData["section"].stringValue
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedPageViewController") as! DetailedPageViewController
        detailVC.delegate = self
        let bid = self.bookmarkArray[indexPath.row]
        detailVC.thumbnailData = bid
        if self.bookmarkArray.firstIndex(of: bid) != nil {
            detailVC.parentIsBookmarked = true
        } else {
            detailVC.parentIsBookmarked = false
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func toggleBookmark(id: String) {
        if self.bookmarkArray.firstIndex(of: id) != nil {
            self.bookmarkArray = self.bookmarkArray.filter{$0 != id}
        } else {
            self.bookmarkArray.append(id)
        }
        defaults.set(self.bookmarkArray, forKey: "bookmarkArray")
        self.bookmarksCollection.reloadData()
    }
    
}


