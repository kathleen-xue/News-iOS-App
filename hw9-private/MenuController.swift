//
//  MenuController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 5/6/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit

extension BookmarksViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint)
    -> UIContextMenuConfiguration? {
      let twitter = UIAction(title: "Share with Twitter",
                              image: UIImage(named: "twitter")) { _ in
                                 UIApplication.shared.openURL(NSURL(string: "https://twitter.com/intent/tweet?text=Check%20out%20this%20article!&hashtags=CSCI571&url=\(self.url)")! as URL)
      }

      let bookmark = UIAction(title: "Bookmark",
        image: UIImage(systemName: "bookmark.fill")) { action in
            self.isBookmarked = false
            let defaults = UserDefaults.standard
            var bookmarkArray = defaults.object(forKey: "bookmarkArray") as? [String] ?? [String]()
            if bookmarkArray.firstIndex(of: self.id) != nil {
                bookmarkArray = bookmarkArray.filter{$0 != self.id}
            }
            defaults.set(bookmarkArray, forKey: "bookmarkArray")
            self.updateTableView()
      }

       return UIContextMenuConfiguration(identifier: nil,
         previewProvider: nil) { _ in
         UIMenu(title: "Actions", children: [twitter, bookmark])
       }
    }
}
