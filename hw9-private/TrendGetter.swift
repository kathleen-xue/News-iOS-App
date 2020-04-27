//
//  TrendGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/26/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class TrendGetter {
    let url = "http://kxue-nodejs.us-east-1.elasticbeanstalk.com/googleTrends?q="
    var data = [Any]()
    func getTrends(q: String, completion: @escaping (Array<Any>) -> Void) -> Void {
        let getUrl = url + q
        print(getUrl)
        guard let encodedURL = getUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("invalid url")
            return
        }
        Alamofire.request(encodedURL)
            .responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let ret_ = swiftyJsonVar.array {
                    //print(ret_)
                    self.data = ret_
                    completion(self.data)
                }
            }
        }
    }
}
