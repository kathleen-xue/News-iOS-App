//
//  Formatter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/26/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class Formatter {
    func formatTime(time: String) -> String {
        var dateAgo = "NaNs ago"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:time)!
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1
        let string = String(formatter.string(from: date, to: now)!)
        dateAgo = "\(string) ago"
        return dateAgo
    }
    
    func formatTraditionalDate(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "dd MMM, yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
}
