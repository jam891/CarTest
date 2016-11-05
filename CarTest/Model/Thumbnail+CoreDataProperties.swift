//
//  Thumbnail+CoreDataProperties.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import Foundation
import CoreData 

extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail");
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var car: Car?

}
