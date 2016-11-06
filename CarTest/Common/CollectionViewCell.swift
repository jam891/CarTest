//
//  CollectionViewCell.swift
//  CarTest
//
//  Created by Vitaliy Delidov on 11/7/16.
//  Copyright © 2016 Vitaliy Delidov. All rights reserved.
//

import UIKit

class CollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var images = [UIImage]()
    
}


// MARK: - UICollectionViewDataSource

extension CollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCell.reuseIdentifier, for: indexPath) as! AddImageCell
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 88, height: 88)
    }
    
}
