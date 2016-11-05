//
//  CarTableViewCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CarCell"
    
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    var car: Car! {
        didSet {
            carModel.text = car.model
            carPrice.text = String(format: "%d$", car.price)// extension!
        }
    }

}
