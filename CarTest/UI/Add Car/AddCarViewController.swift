//
//  AddCarViewController.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit
import CoreData

class AddCarViewController: UITableViewController {
    
    @IBOutlet weak var photosCell: CollectionViewCell!
    @IBOutlet weak var modelCell: TextFieldCell!
    @IBOutlet weak var priceCell: TextFieldCell!
    @IBOutlet weak var engineCell: PickerViewCell!
    @IBOutlet weak var transmissionCell: PickerViewCell!
    @IBOutlet weak var conditionCell: PickerViewCell!
    @IBOutlet weak var descriptionCell: TextViewCell!
    
    typealias DidFinishDelegate = (_ carModel: CarData) -> Void
    var didFinish: DidFinishDelegate?


    var cells = [UITableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cells.append(photosCell)
        cells.append(modelCell)
        cells.append(priceCell)
        cells.append(engineCell)
        cells.append(transmissionCell)
        cells.append(conditionCell)
        cells.append(descriptionCell)
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(AddCarViewController.dismissKeyboard(_:)))
        view.addGestureRecognizer(dismissTap)
    }
    
    // MARK: - Dismiss Keyboard
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    // MARK: - Actions
    
    @IBAction func save(sender: UIBarButtonItem) {
        let model = modelCell.textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let price = priceCell.textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let desc  = descriptionCell.textView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let carData = CarData(model: model, price: Int16(price)!, desc: desc)
        didFinish!(carData)
    }

}




