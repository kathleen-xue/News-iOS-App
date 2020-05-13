//
//  HeadlineSectionCell.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/27/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
class HeadlineSectionCell: UITableViewCell {
    var i = 0
    @IBOutlet weak var headlineSectionImg: UIImageView!
    @IBOutlet weak var headlineSectionTitle: UILabel!
    @IBOutlet weak var headlineSectionDate: UILabel!
    
    @IBOutlet weak var headlineSectionSection: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var bookmarkButtonAction : (() -> ())?
    var id = ""
    var url = ""
    var isBookmarked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.headlineSectionImg.layer.cornerRadius = 10
        self.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
    
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton){
        //print("tappeddddd")
      bookmarkButtonAction?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
