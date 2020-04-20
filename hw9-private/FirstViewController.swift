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
import Kingfisher

class FirstViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherApiImg: UIImageView!
    @IBOutlet weak var weatherApiCity: UILabel!
    @IBOutlet weak var weatherApiState: UILabel!
    @IBOutlet weak var weatherApiTemp: UILabel!
    @IBOutlet weak var weatherApiFeat: UILabel!
    @IBOutlet weak var homeNewsTable: UITableView!
    var locationManager: CLLocationManager!
    let geoCoder = CLGeocoder()
    var city = "Palo Alto"
    var state = "CA"
    var locationLat = 37.439
    var locationLon = -122.14
    var homeNewsData = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeNewsTable.dataSource = self
        homeNewsTable.delegate = self
        //homeNewsTable.register(HomeNewsTableCell.self, forCellReuseIdentifier: "homeNewsCell")
        homeNewsTable.reloadData()
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
        let homeNews = HomeNewsGetter()
        homeNews.getHomeNews(completion: { (data) -> Void in
            //print(data)
            self.homeNewsData = data
            self.homeNewsTable.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeNewsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.homeNewsData)
        return self.homeNewsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeNewsCell", for: indexPath) as! HomeNewsTableCell
        //cell.textLabel?.text = "HI"
        let currentJson = JSON(self.homeNewsData[indexPath.item])
        if let section = currentJson["sectionName"].string {
            cell.homeNewsTableSection?.text = section
        }
        else {
            cell.homeNewsTableSection?.text = "None"
        }
        if let title = currentJson["webTitle"].string {
            cell.homeNewsTableTitle?.text = title
        }
        else {
            cell.homeNewsTableTitle?.text = "None"
        }
        if let imgUrlString =  currentJson["fields"]["thumbnail"].string {
            let url = URL(string: imgUrlString)
            cell.homeNewsTableImg?.kf.setImage(with: url)
        }
        else {
            cell.homeNewsTableImg?.image = UIImage(named: "default-guardian")
        }
        if let publishedTime = currentJson["webPublicationDate"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:publishedTime)!
            let now = Date()
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
            formatter.maximumUnitCount = 2
            let string = formatter.string(from: date, to: now)
            cell.homeNewsTableTime?.text = string
        }
        else {
            cell.homeNewsTableTime?.text = "NaNs ago"
        }
        return cell
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

