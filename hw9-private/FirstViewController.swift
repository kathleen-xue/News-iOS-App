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
                }
                print("Data:\n\(String(describing: dataString))")
            }
            else {
                print("Error:\n\(String(describing: error))")
                //Http error
            }
        }.resume()
    }
    //MARK: Actions

}

