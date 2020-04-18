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
    var temperature = "0"
    var features = "none"
    func getWeather(city: String, completion: @escaping (Bool)->()) -> (String, String) {
    _ = "http://api.openweathermap.org/data/2.5/weather"
    _ = "0411db9d99ea4753e711226ad39d3157"
    let request = NSMutableURLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=palo%20alto&appid=0411db9d99ea4753e711226ad39d3157")!)
    
    URLSession.shared.dataTask(with: request as URLRequest) {
    (data, response, error) in
        guard let httpResponse = response as?
            HTTPURLResponse else {
                //Error
                print("Error:\n\(String(describing: error))")
                completion(true)
                return
        }
        if httpResponse.statusCode == 200 {
            //Http success
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            let json = JSON.init(parseJSON: dataString!)
            print(json)
            if let temp = json["main"]["temp"].double {
                print(temp)
                self.temperature = "\(Int(temp-273.15))°C"
                completion(true)
            }
            else {
                self.temperature = "0"
                completion(true)
            }
            if let feat = json["weather"][0]["main"].string {
                //print(feat)
                self.features = feat
                completion(true)
            }
            else {
                self.features = "none"
                completion(true)
            }
        }
        else {
            print("Error:\n\(String(describing: error))")
            //Http error
            completion(true)
        }
    }.resume()
        print(temperature)
        print(features)
    return(temperature, features)
  }
}
