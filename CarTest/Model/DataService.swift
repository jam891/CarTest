//
//  DataService.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import CoreData
import SwiftyJSON

class DataService {
    
    static let instance = DataService()
    
    
    func storeWeather(_ json: JSON) {
        let weatherClassName: String = String(describing: Weather.self)
        let weather = NSEntityDescription.insertNewObject(forEntityName: weatherClassName, into: CoreData.context) as! Weather
        weather.timeStamp = NSDate()
        weather.json = json.rawString()
        
        CoreData.saveContext()
    }
    
    func getWeather() -> JSON? {
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        let results = try! CoreData.context.fetch(fetchRequest)
        return JSON.parse((results.last?.json)!)
    }
    
    func storeCar(_ carData: CarData) {
        let carClassName: String = String(describing: Car.self)
        let car = NSEntityDescription.insertNewObject(forEntityName: carClassName, into: CoreData.context) as! Car
        car.model = carData.model
        car.price = carData.price
        car.desc  = carData.desc
        car.images = carData.images
        
        CoreData.saveContext()
    }
    
}
