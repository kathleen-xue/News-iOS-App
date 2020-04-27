//
//  HomeNewsTableCell.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/19/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
class HomeNewsTableCell: UITableViewCell {
    @IBOutlet weak var homeNewsTableImg: UIImageView!
    @IBOutlet weak var homeNewsTableTime: UILabel!
    @IBOutlet weak var homeNewsTableSection: UILabel!
    @IBOutlet weak var homeNewsTableTitle: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    var bookmarkButtonAction : (() -> ())?
    override func awakeFromNib() {
     //still empty yet
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.homeNewsTableImg.layer.cornerRadius = 10
        self.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton){
      // if the closure is defined (not nil)
      // then execute the code inside the subscribeButtonAction closure
      bookmarkButtonAction?()
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
