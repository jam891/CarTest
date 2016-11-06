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
        let weather = NSEntityDescription.insertNewObject(forEntityName: weatherClassName, into: CoreDataStack.context) as! Weather
        weather.timeStamp = NSDate()
        weather.json = json.rawString()
        
        CoreDataStack.saveContext()
    }
    
    func getWeather() -> JSON? {
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        let results = try! CoreDataStack.context.fetch(fetchRequest)
        return JSON.parse((results.last?.json)!)
    }
    
    func storeCar(_ carData: CarData) {
        let carClassName: String = String(describing: Car.self)
        let car = NSEntityDescription.insertNewObject(forEntityName: carClassName, into: CoreDataStack.context) as! Car
        car.model = carData.model
        car.price = carData.price
        car.desc  = carData.desc
        
        CoreDataStack.saveContext()
    }
    
    func storeImage(_ imageData: NSData) {
        let imageClassName: String = String(describing: Thumbnail.self)
        let thumbnail = NSEntityDescription.insertNewObject(forEntityName: imageClassName, into: CoreDataStack.context) as! Thumbnail
        thumbnail.imageData = imageData
        
        CoreDataStack.saveContext()
    }

}
