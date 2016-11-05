//
//  WeatherView.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherView: UIView {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var weatherJson: JSON! {
        didSet {
            let city     = weatherJson["name"].stringValue
            let temp     = weatherJson["main"]["temp"].double
            let country  = weatherJson["sys"]["country"].stringValue
            let iconType = weatherJson["weather"][0]["icon"].stringValue
            let desc     = weatherJson["weather"][0]["description"].stringValue
            
            cityLabel.text = city
            descLabel.text = desc.capitalized
            iconImageView.image  = iconByType(iconType)
            backgroundView.image = UIImage.init(named: "nature")
            tempLabel.text = String(Int(tempByCountry(country, temp: temp!)))
        }
    }
    
    
    private func tempByCountry(_ country: String, temp: Double) -> Double {
        if country == "US" {
            return round(((temp - 273.15) * 1.8) + 32)
        } else {
            return round(temp - 273.15)
        }
    }
    
    private func iconByType(_ type: String) -> UIImage {
        return UIImage(named: type) ?? UIImage(named: "placeholder")!
    }


}
