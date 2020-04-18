//
//  FirstViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/13/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weather = WeatherGetter()
        weather.getWeather(city:"Palo%20Alto")
    }


}

