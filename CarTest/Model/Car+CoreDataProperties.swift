//
//  Car+CoreDataProperties.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import Foundation
import CoreData 

extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car");
    }

    @NSManaged public var model: String?
    @NSManaged public var price: Int16
    @NSManaged public var desc: String?
    @NSManaged public var images: Set<Thumbnail>?

}

// MARK: Generated accessors for images
extension Car {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Thumbnail)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Thumbnail)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}
