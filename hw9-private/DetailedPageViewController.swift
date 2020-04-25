//
//  DetailedPageViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/24/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import os.log
import SwiftyJSON
import CoreLocation
import MapKit
import Kingfisher

class DetailedPageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailedPageImg: UIImageView!
    @IBOutlet weak var detailedPageSection: UILabel!
    @IBOutlet weak var detailedPageDate: UILabel!
    @IBOutlet weak var detailedPageBody: UILabel!
    @IBOutlet weak var detailedPageTitle: UILabel!
    var thumbnailData: String?
    var image: String = "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"
    var newsTitle: String = ""
    var section: String = ""
    var date: String = ""
    var bodyText: String = ""
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
    }
    
    /*override func viewDidLayoutSubviews() {
        self.scrollView.isScrollEnabled = true
        self.scrollView.contentSize = CGSize(width: 414, height: 1700) // height should be grater than scrollview's frame height
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("in view will appear")
        if let thumbnailData = thumbnailData {
            let getter = DetailedNewsGetter()
            getter.getDetailedNews(id: thumbnailData, completion: {(data) -> Void in
                self.image = data["image"] ?? "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"
                self.newsTitle = data["title"] ?? "None"
                self.section = data["section"] ?? "None"
                self.date = data["date"] ?? "None"
                self.bodyText = data["bodyText"] ?? "None"
                self.url = data["url"] ?? "https://theguardian.com"
                let imgurl = URL(string: self.image)
                print()
                let imgdata = try? Data(contentsOf: imgurl!)
                self.detailedPageImg.image = UIImage(data: imgdata!)
                self.detailedPageTitle.text = self.newsTitle
                self.detailedPageBody.attributedText = self.bodyText.htmlAttributedString()
                self.detailedPageDate.text = self.date
                self.detailedPageSection.text = self.section
            })
        }
    }
}

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
}
