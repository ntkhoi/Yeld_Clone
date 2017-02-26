//
//  Utility.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard


let keyofferaDealSwitch: String = "KeyofferaDealSwitch"
let keyofdicswitchCategory: String = "KeydictswitchCateory"
let keyDefaultDistance = "keyDefaultDistan"
let keyDefaulSort = "keyDefaulSort"

// Convert from miles to kilometers (Integer)
func milesTometers(speedInMPH:Double) ->Double {
    let speedInKPH = speedInMPH * 1.60934
    return speedInKPH*1000 as Double
}
