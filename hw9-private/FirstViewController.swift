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

class FirstViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherApiImg: UIImageView!
    @IBOutlet weak var weatherApiCity: UILabel!
    @IBOutlet weak var weatherApiState: UILabel!
    @IBOutlet weak var weatherApiTemp: UILabel!
    @IBOutlet weak var weatherApiFeat: UILabel!
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        var locationLat = 37.439
        var locationLon = -122.14
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        var city = "Palo Alto"
        var state = "CA"
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            locationLat = locValue.latitude
            locationLon = locValue.longitude
            
            let location = CLLocation(latitude: locationLat, longitude: locationLon)
            geoCoder.reverseGeocodeLocation(location, completionHandler:
                {
                    placemarks, error -> Void in

                    // Place details
                    guard let placeMark = placemarks?.first else { return }
                    state = placeMark.administrativeArea ?? "CA"
                    // City
                    city = placeMark.subAdministrativeArea ?? "Palo Alto"
            })
        }
        let weather = WeatherGetter()
        state = weather.convertStateToLongState(state: state)
        weatherApiFeat.textColor = UIColor.white
        weatherApiTemp.textColor = UIColor.white
        weatherApiCity.textColor = UIColor.white
        weatherApiState.textColor = UIColor.white
        weather.getWeather(lat: locationLat, lon: locationLon) {
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

