//
//  ConditionCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/5/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class ConditionCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    private let pickerOption = [
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


}
