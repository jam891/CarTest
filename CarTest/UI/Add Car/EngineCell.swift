//
//  EngineCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class EngineCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    fileprivate let pickerOption = [
        "unknown",
        "noun",
        "pronoun",
        "adjective",
        "numeral",
        "infinitive",
        "verb",
        "participle",
        "gerund",
        "adverb",
        "conjunction",
        "particle",
        "interjection",
        "preposition"
    ]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textField.inputView = pickerView
    }



}


// MARK: - UIPickerViewDataSource

extension EngineCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOption.count
    }
    
}


// MARK: - UIPickerViewDelegate

extension EngineCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            textField.text = ""
            return
        }
        textField.text = pickerOption[row]
    }
    
}

