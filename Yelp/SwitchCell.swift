//
//  SwitchCell.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

 protocol SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell , didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    var delegate: SwitchCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var settingFieldLable: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func onShowPicker(_ sender: UIButton) {
        
        print("onShowPicker")
        
    }
    @IBAction func onSwitch(_ sender: UISwitch) {
        print("On switch change")
        delegate.switchCell(switchCell: self, didChangeValue: sender.isOn)
        
    }
}
