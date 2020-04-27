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

class HeadlineSectionViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headlineSectionTable: UITableView!
    
    let getter = HeadlineSectionGetter()
    var section = ""
    var data = [Any]()
    override func viewDidLoad() {
        let sectionName = self.section.uppercased()
        SwiftSpinner.show("Loading \(sectionName) Headlines...")
        super.viewDidLoad()
        headlineSectionTable.dataSource = self
        headlineSectionTable.delegate = self
        headlineSectionTable.rowHeight = 110
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.section.uppercased())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineSectionCell", for: indexPath) as! HeadlineSectionCell
        let jsonData = JSON(self.data[indexPath.item])
        let thumbUrl = URL(string: jsonData["img"].stringValue)
        cell.headlineSectionImg?.kf.setImage(with: thumbUrl, placeholder: UIImage(named: "default-guardian"))
        cell.headlineSectionTitle.text = jsonData["title"].stringValue
        cell.headlineSectionSection.text = jsonData["section"].stringValue
        cell.headlineSectionDate.text = jsonData["date"].stringValue
        return cell
    }
    
}

