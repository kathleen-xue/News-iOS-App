//
//  TrendViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/26/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import Charts
import SwiftyJSON

class TrendViewController : UIViewController, UISearchBarDelegate {
    @IBOutlet weak var trendChart: LineChartView!
    @IBOutlet weak var trendSearch: UISearchBar!
    var data = LineChartData()
    var searchQuery = ""
    let getter = TrendGetter()
    var yArr = [ChartDataEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        trendSearch.delegate = self
        self.searchQuery = "Coronavirus"
        getter.getTrends(q: searchQuery, completion: { (data) -> Void in
            print(data)
            let jsonArr = JSON(data).arrayValue
            self.yArr = []
            if jsonArr.count > 0 {
                for i in 0...jsonArr.count-1 {
                    let cur = JSON(jsonArr[i])
                    let val = cur["value"].arrayValue
                    self.yArr.append(ChartDataEntry(x: Double(i), y: Double(val[0].intValue)))
                }
            }
            self.data = LineChartData()
            let ds = LineChartDataSet(entries: self.yArr, label: "Trending Chart for \(self.searchQuery)")
            self.data.addDataSet(ds)
            self.trendChart.data = self.data
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchQuery = self.trendSearch.text ?? ""
        print(self.searchQuery)
        getter.getTrends(q: searchQuery, completion: { (data) -> Void in
            print(data)
            let jsonArr = JSON(data).arrayValue
            self.yArr = []
            if jsonArr.count > 0 {
                for i in 0...jsonArr.count-1 {
                    let cur = JSON(jsonArr[i])
                    let val = cur["value"].arrayValue
                    self.yArr.append(ChartDataEntry(x: Double(i), y: Double(val[0].intValue)))
                }
            }
            self.data = LineChartData()
            let ds = LineChartDataSet(entries: self.yArr, label: "Trending Chart for \(self.searchQuery)")
            self.data.addDataSet(ds)
            self.trendChart.data = self.data
        })
    }
}
