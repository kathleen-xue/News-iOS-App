//
//  FirstViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/13/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import UIKit

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
        weather.getWeather(city:"Palo%20Alto")
    }
    //MARK: Actions

}

