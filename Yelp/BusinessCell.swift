//
//  BusinessCell.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var restauranceImage: UIImageView!
    
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var reviewcountLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var categorylable: UILabel!
    
    var business: Business! {
        didSet{
            nameLable.text = business.name
            distanceLable.text = business.distance
            reviewcountLable.text = String(describing: business.reviewCount)
            addressLable.text = business.address
            categorylable.text = business.categories
            restauranceImage.setImageWith(business.imageURL!)
            ratingImage.setImageWith(business.ratingImageURL!)
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
