//
//  WeatherGetter.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/16/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import Foundation
import SwiftyJSON
 
class WeatherGetter {
  func getWeather(city: String) {
    _ = "http://api.openweathermap.org/data/2.5/weather"
    _ = "0411db9d99ea4753e711226ad39d3157"
    let request = NSMutableURLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=palo%20alto&appid=0411db9d99ea4753e711226ad39d3157")!)
    
    URLSession.shared.dataTask(with: request as URLRequest) {
    (data, response, error) in
        guard let httpResponse = response as?
            HTTPURLResponse else {
                //Error
                print("Error:\n\(String(describing: error))")
                return
        }
        if httpResponse.statusCode == 200 {
            //Http success
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                let temperature = json["main"]["temp"]
                let city = json["name"]
                let state = "California"
                let features = json["weather"][0]["main"]
                return json
            }
            print("Data:\n\(String(describing: dataString))")
        }
        else {
            print("Error:\n\(String(describing: error))")
            //Http error
        }
    }.resume()
  }
}
