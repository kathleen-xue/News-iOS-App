//
//  DetailedPageViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/24/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation
import MapKit
import Kingfisher

class DetailedPageViewController: UIViewController {
    
    @IBOutlet weak var detailedPageImg: UIImageView!
    @IBOutlet weak var detailedPageSection: UILabel!
    @IBOutlet weak var detailedPageDate: UILabel!
    @IBOutlet weak var detailedPageBody: UITextView!
    @IBOutlet weak var detailedPageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
