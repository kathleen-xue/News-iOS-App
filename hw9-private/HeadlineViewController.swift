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

class HeadlineViewController: ButtonBarPagerTabStripViewController {
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        
        buttonBarView.selectedBar.backgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
        guard changeCurrentIndex == true else { return }
        oldCell?.label.textColor = .black
        newCell?.label.textColor = self?.purpleInspireColor
        }
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
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

