//
//  FirstViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/13/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import UIKit
import SwiftyJSON

class FirstViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherApiImg: UIImageView!
    @IBOutlet weak var weatherApiCity: UILabel!
    @IBOutlet weak var weatherApiState: UILabel!
    @IBOutlet weak var weatherApiTemp: UILabel!
    @IBOutlet weak var weatherApiFeat: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let weather = WeatherGetter()
        let city = "Palo Alto"
        let state = "California"
        weatherApiFeat.textColor = UIColor.white
        weatherApiTemp.textColor = UIColor.white
        weatherApiCity.textColor = UIColor.white
        weatherApiState.textColor = UIColor.white
        weather.getWeather(city: city) {
            isValid in
            print(isValid)
            // do something with the returned Bool
            DispatchQueue.main.async {
               // update UI
                self.weatherApiTemp.text = weather.temperature
                self.weatherApiFeat.text = weather.features
                if weather.features == "Clouds" {
                    self.weatherApiImg.image = UIImage(named: "cloudy_weather")
                }
                else if weather.features == "Clear" {
                    self.weatherApiImg.image = UIImage(named: "clear_weather")
                }
                else if weather.features == "Snow" {
                    self.weatherApiImg.image = UIImage(named: "snowy_weather")
                }
                else if weather.features == "Rain" {
                    self.weatherApiImg.image = UIImage(named: "rainy_weather")
                }
                else if weather.features == "Thunderstorm" {
                    self.weatherApiImg.image = UIImage(named: "thunder_weather")
                }
                else {
                    self.weatherApiImg.image = UIImage(named: "sunny_weather")
                }
            }
        }
        weatherApiImg.layer.cornerRadius = weatherApiImg.frame.height/8.0
        weatherApiImg.clipsToBounds = true
        weatherApiCity.text = city
        weatherApiState.text = state
    }
    //MARK: Actions

}

