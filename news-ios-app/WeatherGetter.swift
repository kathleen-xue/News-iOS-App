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
    func getWeather(lat: Double, lon: Double, completion: @escaping (Bool)->()) -> (String, String) {
    _ = "http://api.openweathermap.org/data/2.5/weather"
    _ = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}"
    let apiKey = "0411db9d99ea4753e711226ad39d3157"
    let request = NSMutableURLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)")!)
    
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
    func convertStateToLongState(state: String) -> (String) {
        let stateCodes = ["AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
        let fullStateNames = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
        for i in 0...50 {
            if state == stateCodes[i] {
                return fullStateNames[i]
            }
        }
        return state
    }
}
