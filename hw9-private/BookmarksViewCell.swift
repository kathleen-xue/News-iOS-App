//
//  BookmarksViewCell.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/27/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit

class BookmarksViewCell : UICollectionViewCell {
    @IBOutlet weak var bookmarksButton: UIButton!
    @IBOutlet weak var bookmarksSection: UILabel!
    @IBOutlet weak var bookmarksDate: UILabel!
    @IBOutlet weak var bookmarksTitle: UILabel!
    @IBOutlet weak var bookmarksImg: UIImageView!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
}


