//
//  OpenWeatherMap.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CoreLocation

class OpenWeatherMap {

    typealias Completion = (_ data: JSON?, _ error: Error?) -> Void
    
    private static let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private static let openWeatherMapAPIKey  = "9c563fd3bbbb0535e6a14eb42d9b6fe4"
    private static var locale: String! {
        return NSLocale.preferredLanguages.first
    }
    
    
    
    class func currentWeatherFor(_ location: CLLocationCoordinate2D, completion: @escaping Completion) {
        let parameters: [String : Any] = [
            "lang"  : locale,
            "lat"   : location.latitude,
            "lon"   : location.longitude,
            "appid" : openWeatherMapAPIKey
        ]
        
        request(openWeatherMapBaseURL, method: .get, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(JSON(value), nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
        
    }
    
}
