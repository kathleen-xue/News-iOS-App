//
//  HeadlineSectionGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/27/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HeadlineSectionGetter {
    var data = [Any]()
    func getHeadlineResults(section: String, completion: @escaping (Array<Any>) -> Void) -> Void {
        let url =  "http://kxue-nodejs.us-east-1.elasticbeanstalk.com/\(section)/guardian"
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("invalid url")
            return
        }
        self.data = [Any]()
        Alamofire.request(encodedURL)
            .responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let ret_ = swiftyJsonVar["results"].array {
                    if ret_.count > 0 {
                        for i in 0...ret_.count - 1 {
                            let json = JSON(ret_[i])
                            let id = json["id"].stringValue
                            let title = json["webTitle"]
                            let section = json["sectionName"]
                            let webUrl = json["webUrl"]
                            let dateFormatter = Formatter()
                            let dateAgo = dateFormatter.formatTime(time: json["webPublicationDate"].stringValue)
                            let imgArray = json["blocks"]["main"]["elements"][0]["assets"].arrayValue
                            var img = ""
                            if imgArray.count > 0 {
                                let jsonImg = JSON(imgArray[imgArray.count - 1])
                                let imgUrl = jsonImg["file"].stringValue
                                img = imgUrl
                                print(img)
                            } else {
                                img = ""
                            }
                            self.data.append(["id": id, "title": title, "section": section, "url": webUrl, "date": dateAgo, "img": img])
                        }
                    }
                    completion(self.data)
                }
            }
        }
    }
}
