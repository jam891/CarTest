//
//  TextViewCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/7/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

protocol DynamicHeightCell {
    func heightForCellAtIndexPath(indexPath: NSIndexPath, tableView: UITableView) -> CGFloat
}

class TextViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    
    func calculateHeightForCell(_ cell: TextViewCell) -> CGFloat {
        let textViewWidth = cell.textView.frame.size.width
        let size = cell.textView.sizeThatFits(CGSize.init(width: textViewWidth, height: .greatestFiniteMagnitude))
        return size.height + 10
    }

}


// MARK: - UITextViewDelegate

extension TextViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        tableView!.beginUpdates()
        tableView!.endUpdates()
    }
    
}


// MARK: - DynamicHeightCell

extension TextViewCell: DynamicHeightCell {
    
    func heightForCellAtIndexPath(indexPath: NSIndexPath, tableView: UITableView) -> CGFloat {
        let height = calculateHeightForCell(self)
        return height
    }
    
}
