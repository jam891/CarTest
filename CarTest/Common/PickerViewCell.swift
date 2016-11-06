//
//  PickerViewCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/6/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class PickerViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    var pickerOption: [String]!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
    }

}



// MARK: - UIPickerViewDataSource

extension PickerViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOption.count
    }

}


// MARK: - UIPickerViewDelegate

extension PickerViewCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerOption[row]
    }

}

