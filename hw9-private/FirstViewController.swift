//
//  FirstViewController.swift
//  hw9-private
//
//  Created by Kathleen Xue on 4/13/20.
//  Copyright © 2020 Kathleen Xue. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate  {
    //MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherApiImg: UIImageView!
    @IBOutlet weak var weatherApiCity: UILabel!
    @IBOutlet weak var weatherApiState: UILabel!
    @IBOutlet weak var weatherApiTemp: UILabel!
    @IBOutlet weak var weatherApiFeat: UILabel!
    var locationManager: CLLocationManager!
    let geoCoder = CLGeocoder()
    var city = "Palo Alto"
    var state = "CA"
    var locationLat = 37.439
    var locationLon = -122.14
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        weatherApiFeat.textColor = UIColor.white
        weatherApiTemp.textColor = UIColor.white
        weatherApiCity.textColor = UIColor.white
        weatherApiState.textColor = UIColor.white
        
        weatherApiImg.layer.cornerRadius = weatherApiImg.frame.height/8.0
        weatherApiImg.clipsToBounds = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.locationLat = locValue.latitude
        self.locationLon = locValue.longitude
        let weather = WeatherGetter()
        let location = CLLocation(latitude: locationLat, longitude: locationLon)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                // Place details
                guard let placeMark = placemarks?.first else { return }
                self.state = placeMark.administrativeArea ?? "CA"
                self.state = weather.convertStateToLongState(state: self.state)
                print(self.state)
                self.weatherApiState.text = self.state
                // City
                self.city = placeMark.subAdministrativeArea ?? "Palo Alto"
                print(self.city)
                self.weatherApiCity.text = self.city
        })
        weather.getWeather(lat: self.locationLat, lon: self.locationLon) {
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
    }
}

