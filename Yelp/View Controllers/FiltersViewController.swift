//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


protocol FiltersViewControllerDelegate {
    func filtersVewController(filterVC: FiltersViewController , didupdateFilters filters: [String] ,isOfferADeal :Bool)
}

enum PrefSectionIdentifier: String {
    case OfferADeal = "Offer a deal"
    case Distance = "Distance"
    case SortBy = "Sort by"
    case Category = "Category"
}

enum PrefRowIdentifier : String {
    case AutoRefresh = "Auto Refresh"
    case PlaySounds = "Play Sounds"
    case ShowPhotos = "Show Photos"
}



class FiltersViewController: UIViewController {
    
    
    
    let categories: [Dictionary<String , String>] = [["name" : "Afghan", "code": "afghani"],
                                                     ["name" : "African", "code": "african"],
                                                     ["name" : "American, New", "code": "newamerican"],
                                                     ["name" : "Venison", "code": "venison"],
                                                     ["name" : "Vietnamese", "code": "vietnamese"],
                                                     ["name" : "Wok", "code": "wok"],
                                                     ["name" : "Wraps", "code": "wraps"],
                                                     ["name" : "Yugoslav", "code": "yugoslav"]]
    
    let tableStructure: [PrefSectionIdentifier] = [ .OfferADeal , .Distance , .SortBy , .Category]
    
    
    var switchStates =  [Int: Bool]()
    var delegate: FiltersViewControllerDelegate!
    var isOfferAdealOn : Bool = false
    
    @IBOutlet weak var tableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        var filter = [String]()
        for (row , isSelected) in switchStates{
            if isSelected {
                
                filter.append(categories[row]["code"]!)
            }
        }
        if filter.count > 0 {
            delegate.filtersVewController(filterVC: self, didupdateFilters: filter,isOfferADeal: isOfferAdealOn)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancle(_ sender: UIBarButtonItem) {
        // TODO : SAVE DATA
        
        
        dismiss(animated: true, completion: nil )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension FiltersViewController: UITableViewDelegate , UITableViewDataSource, SwitchCellDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getEachSectionCount(sectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        switch getSectionType(sectionIndex: indexPath.section) {
        case .OfferADeal:
            cell.pickButton.isHidden = true
            cell.settingFieldLable.text = "Offer a Deal"
            cell.switchButton.isOn = isOfferAdealOn 
            break;
        case .Category:
            cell.pickButton.isHidden = true
            cell.settingFieldLable.text = categories[indexPath.row]["name"]
            cell.switchButton.isOn = switchStates[indexPath.row] ?? false
        case .Distance:
            cell.settingFieldLable.text = "Distance"
            cell.switchButton.isHidden = true
            cell.pickButton.isHidden = false
            break
        case .SortBy:
            cell.settingFieldLable.text = "Auto"
            cell.switchButton.isHidden = true
            cell.pickButton.isHidden = false
            break;
        }
        
        cell.delegate = self
        
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let id = tableView.indexPath(for: switchCell)
        switch getSectionType(sectionIndex: (id?.section)!) {
        case.OfferADeal:
            isOfferAdealOn = value
        case .Category:
            switchStates[(id?.row)!] = value
        default:
            break
        }
        
    }
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableStructure[section].rawValue
    }
    
}

// private func
extension FiltersViewController{
    
    fileprivate func getSectionType(sectionIndex: Int)->PrefSectionIdentifier{
        return tableStructure[sectionIndex]
    }
    
    fileprivate func getEachSectionCount(sectionIndex: Int) -> Int{
        switch  getSectionType(sectionIndex: sectionIndex) {
        case .OfferADeal:
            return 1
        case .Distance:
            return 1
        case .SortBy:
            return 1
        case .Category:
            return categories.count
        default:
            break
        }
    }
    
}
