//
//  SeeallCell.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol SeeallCellDelegate {
    func seeallCell(seallCell: SeeallCell )
}
class SeeallCell: UITableViewCell {

    var delegate: SeeallCellDelegate!
    @IBOutlet weak var seeallButton: UIButton!
    
    @IBAction func onSeeonTouchUp(_ sender: UIButton) {
        delegate.seeallCell(seallCell: self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
