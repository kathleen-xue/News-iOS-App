//
//  HomeNewsGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/18/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HomeNewsGetter {
    var data = [Any]()
    let homeNewsUrl = "http://kxue-nodejs.us-east-1.elasticbeanstalk.com/latestArticlesGuardian"
    func getHomeNews(completion: @escaping (Array<Any>) -> Void) {
        Alamofire.request(homeNewsUrl).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let ret_ = swiftyJsonVar["response"]["results"].array {
                    self.data = ret_
                    print(self.data)
                    completion(self.data)
                }
            }
        }
    }
}
