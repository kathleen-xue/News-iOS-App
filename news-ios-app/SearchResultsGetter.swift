//
//  SearchResultsGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/26/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class SearchResultsGetter {
    var data = [Any]()
    func getSearchResults(query: String, completion: @escaping (Array<Any>) -> Void) -> Void {
        let searchUrl =  "http://kxue-nodejs.us-east-1.elasticbeanstalk.com/searchResults?query=\(query)"
        guard let encodedURL = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("invalid url")
            return
        }
        Alamofire.request(encodedURL)
            .responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let ret_ = swiftyJsonVar["guardianData"].array {
                    self.data = ret_
                    completion(self.data)
                }
            }
        }
    }
}
