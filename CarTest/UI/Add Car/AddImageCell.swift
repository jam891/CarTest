//
//  AddImageCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/6/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class AddImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AddImageCell"
    
    typealias didTapAddImageButtonDelegate = (_ sender: UIButton) -> Void
    var didTapAddImageButton: didTapAddImageButtonDelegate?
    
    
    
    @IBAction func importPicture(sender: UIButton) {
        didTapAddImageButton!(sender)
    }
    
}



