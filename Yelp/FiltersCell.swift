//
//  FiltersCell.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/25/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


protocol FiltersCellDelegate {
     func filtersCell(filtersCell: FiltersCell , didToogleButtonValueChange value: Bool)
}


class FiltersCell: UITableViewCell {

    @IBOutlet weak var filterNameLable: UILabel!
    @IBOutlet weak var showPickerButton: UIButton!
    var delegate: FiltersCellDelegate!
    
    @IBOutlet weak var comboboxitemLable: UILabel!
    
    @IBAction func onShowPickerTouchUp(_ sender: UIButton) {
        print("Co thang click button kia")
        sender.isSelected = !sender.isSelected
        print ("sender.isSelected \(sender.isSelected)")
        delegate.filtersCell(filtersCell: self, didToogleButtonValueChange: sender.isSelected)
        
    }
    
    var hiddencomboboxitemLable :Bool?{
        didSet{
            comboboxitemLable.isHidden = hiddencomboboxitemLable!
            filterNameLable.isHidden = !hiddencomboboxitemLable!
            showPickerButton.isHidden = !hiddencomboboxitemLable!
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
