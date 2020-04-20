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
    override func awakeFromNib() {
     //still empty yet
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
