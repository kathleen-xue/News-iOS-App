//
//  DetailedNewsGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/24/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DetailedNewsGetter {
    func getDetailedNews(id: String, completion: @escaping ([String:String]) -> Void) {
        let detailedNewsUrl = "http://kxue-nodejs.us-east-1.elasticbeanstalk.com/detailIOS?id=\(id)"
        Alamofire.request(detailedNewsUrl).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                var image = ""
                if let imageArray = swiftyJsonVar["blocks"]["main"]["elements"][0]["assets"].array {
                    if imageArray.count > 0 {
                        image = imageArray[imageArray.count-1]["file"].stringValue
                    }
                    else {
                        image =  "https://assets.guim.co.uk/images/eada8aa27c12fe2d5afa3a89d3fbae0d/fallback-logo.png"
                    }
                }
                let title = swiftyJsonVar["webTitle"].stringValue
                let section = swiftyJsonVar["sectionName"].stringValue
                let date = swiftyJsonVar["webPublicationDate"].stringValue
                var bodyText = ""
                if let bodyArray = swiftyJsonVar["blocks"]["body"].array {
                    for i in 0...bodyArray.count-1 {
                        bodyText.append(bodyArray[i]["bodyHtml"].stringValue)
                    }
                }
                let url = swiftyJsonVar["webUrl"].stringValue
                let data:[String: String] = ["image": image, "title": title, "section": section, "date": date, "bodyText": bodyText, "url": url]
                completion(data)
            }
        }
    }
}
