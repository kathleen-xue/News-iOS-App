//
//  SecondViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/13/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftSpinner

class HeadlineViewController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        buttonBarView.selectedBar.backgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.selectedBarBackgroundColor = .systemBlue
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .lightGray
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
        guard changeCurrentIndex == true else { return }
        oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = .systemBlue
        }
        super.viewDidLoad()
        SwiftSpinner.hide()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        SwiftSpinner.show("Loading Headlines...")
        let world = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        world.section = "world"
        
        let business = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        business.section = "business"
        
        let politics = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        politics.section = "politics"
        
        let sports = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        sports.section = "sports"
        
        let technology = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        technology.section = "technology"
        
        let science = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeadlineSectionView") as! HeadlineSectionViewController
        science.section = "science"
        
        return [world, business, politics, sports, technology, science]
    }


}

