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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
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


