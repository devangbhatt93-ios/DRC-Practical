//
//  FilterCollectionViewCell.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
        
    func prepareCellFor(filter: FilterModel) {
        
        DispatchQueue.main.async {
            self.filterLabel.layer.cornerRadius = 5.0
            self.filterLabel.layer.masksToBounds = true
        }
        
        filterLabel.text = filter.name ?? ""
        filterLabel.backgroundColor = filter.isSelected ? UIColor(displayP3Red: 34.0/255.0, green: 143.0/255.0, blue: 234.0/255.0, alpha: 1.0) : UIColor.clear
        filterLabel.textColor = filter.isSelected ? UIColor.white : UIColor.gray
    }
}
