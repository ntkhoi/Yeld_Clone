//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Nguyen Trong Khoi on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


protocol FiltersViewControllerDelegate {
    func filtersVewController(filterVC: FiltersViewController , didupdateFilters filters: [String] ,isOfferADeal :Bool , sortMode: YelpSortMode , distance: Double?)
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
    
    
    
    let categories: [Dictionary<String , String>] =  [["name" : "Afghan", "code": "afghani"],
                                                      ["name" : "African", "code": "african"],
                                                      ["name" : "American, New", "code": "newamerican"],
                                                      ["name" : "American, Traditional", "code": "tradamerican"],
                                                      ["name" : "Arabian", "code": "arabian"],
                                                      ["name" : "Argentine", "code": "argentine"],
                                                      ["name" : "Armenian", "code": "armenian"],
                                                      ["name" : "Asian Fusion", "code": "asianfusion"],
                                                      ["name" : "Asturian", "code": "asturian"],
                                                      ["name" : "Australian", "code": "australian"],
                                                      ["name" : "Austrian", "code": "austrian"],
                                                      ["name" : "Baguettes", "code": "baguettes"],
                                                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                                                      ["name" : "Barbeque", "code": "bbq"],
                                                      ["name" : "Basque", "code": "basque"],
                                                      ["name" : "Bavarian", "code": "bavarian"],
                                                      ["name" : "Beer Garden", "code": "beergarden"],
                                                      ["name" : "Beer Hall", "code": "beerhall"],
                                                      ["name" : "Beisl", "code": "beisl"],
                                                      ["name" : "Belgian", "code": "belgian"],
                                                      ["name" : "Bistros", "code": "bistros"],
                                                      ["name" : "Black Sea", "code": "blacksea"],
                                                      ["name" : "Brasseries", "code": "brasseries"],
                                                      ["name" : "Brazilian", "code": "brazilian"],
                                                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                                                      ["name" : "British", "code": "british"],
                                                      ["name" : "Buffets", "code": "buffets"],
                                                      ["name" : "Bulgarian", "code": "bulgarian"],
                                                      ["name" : "Burgers", "code": "burgers"],
                                                      ["name" : "Burmese", "code": "burmese"],
                                                      ["name" : "Cafes", "code": "cafes"],
                                                      ["name" : "Cafeteria", "code": "cafeteria"],
                                                      ["name" : "Cajun/Creole", "code": "cajun"],
                                                      ["name" : "Cambodian", "code": "cambodian"],
                                                      ["name" : "Canadian", "code": "New)"],
                                                      ["name" : "Canteen", "code": "canteen"],
                                                      ["name" : "Caribbean", "code": "caribbean"],
                                                      ["name" : "Catalan", "code": "catalan"],
                                                      ["name" : "Chech", "code": "chech"],
                                                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                                                      ["name" : "Chicken Shop", "code": "chickenshop"],
                                                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                                                      ["name" : "Chilean", "code": "chilean"],
                                                      ["name" : "Chinese", "code": "chinese"],
                                                      ["name" : "Comfort Food", "code": "comfortfood"],
                                                      ["name" : "Corsican", "code": "corsican"],
                                                      ["name" : "Creperies", "code": "creperies"],
                                                      ["name" : "Cuban", "code": "cuban"],
                                                      ["name" : "Curry Sausage", "code": "currysausage"],
                                                      ["name" : "Cypriot", "code": "cypriot"],
                                                      ["name" : "Czech", "code": "czech"],
                                                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                                                      ["name" : "Danish", "code": "danish"],
                                                      ["name" : "Delis", "code": "delis"],
                                                      ["name" : "Diners", "code": "diners"],
                                                      ["name" : "Dumplings", "code": "dumplings"],
                                                      ["name" : "Eastern European", "code": "eastern_european"],
                                                      ["name" : "Ethiopian", "code": "ethiopian"],
                                                      ["name" : "Fast Food", "code": "hotdogs"],
                                                      ["name" : "Filipino", "code": "filipino"],
                                                      ["name" : "Fish & Chips", "code": "fishnchips"],
                                                      ["name" : "Fondue", "code": "fondue"],
                                                      ["name" : "Food Court", "code": "food_court"],
                                                      ["name" : "Food Stands", "code": "foodstands"],
                                                      ["name" : "French", "code": "french"],
                                                      ["name" : "French Southwest", "code": "sud_ouest"],
                                                      ["name" : "Galician", "code": "galician"],
                                                      ["name" : "Gastropubs", "code": "gastropubs"],
                                                      ["name" : "Georgian", "code": "georgian"],
                                                      ["name" : "German", "code": "german"],
                                                      ["name" : "Giblets", "code": "giblets"],
                                                      ["name" : "Gluten-Free", "code": "gluten_free"],
                                                      ["name" : "Greek", "code": "greek"],
                                                      ["name" : "Halal", "code": "halal"],
                                                      ["name" : "Hawaiian", "code": "hawaiian"],
                                                      ["name" : "Heuriger", "code": "heuriger"],
                                                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                                                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                                                      ["name" : "Hot Dogs", "code": "hotdog"],
                                                      ["name" : "Hot Pot", "code": "hotpot"],
                                                      ["name" : "Hungarian", "code": "hungarian"],
                                                      ["name" : "Iberian", "code": "iberian"],
                                                      ["name" : "Indian", "code": "indpak"],
                                                      ["name" : "Indonesian", "code": "indonesian"],
                                                      ["name" : "International", "code": "international"],
                                                      ["name" : "Irish", "code": "irish"],
                                                      ["name" : "Island Pub", "code": "island_pub"],
                                                      ["name" : "Israeli", "code": "israeli"],
                                                      ["name" : "Italian", "code": "italian"],
                                                      ["name" : "Japanese", "code": "japanese"],
                                                      ["name" : "Jewish", "code": "jewish"],
                                                      ["name" : "Kebab", "code": "kebab"],
                                                      ["name" : "Korean", "code": "korean"],
                                                      ["name" : "Kosher", "code": "kosher"],
                                                      ["name" : "Kurdish", "code": "kurdish"],
                                                      ["name" : "Laos", "code": "laos"],
                                                      ["name" : "Laotian", "code": "laotian"],
                                                      ["name" : "Latin American", "code": "latin"],
                                                      ["name" : "Live/Raw Food", "code": "raw_food"],
                                                      ["name" : "Lyonnais", "code": "lyonnais"],
                                                      ["name" : "Malaysian", "code": "malaysian"],
                                                      ["name" : "Meatballs", "code": "meatballs"],
                                                      ["name" : "Mediterranean", "code": "mediterranean"],
                                                      ["name" : "Mexican", "code": "mexican"],
                                                      ["name" : "Middle Eastern", "code": "mideastern"],
                                                      ["name" : "Milk Bars", "code": "milkbars"],
                                                      ["name" : "Modern Australian", "code": "modern_australian"],
                                                      ["name" : "Modern European", "code": "modern_european"],
                                                      ["name" : "Mongolian", "code": "mongolian"],
                                                      ["name" : "Moroccan", "code": "moroccan"],
                                                      ["name" : "New Zealand", "code": "newzealand"],
                                                      ["name" : "Night Food", "code": "nightfood"],
                                                      ["name" : "Norcinerie", "code": "norcinerie"],
                                                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                                                      ["name" : "Oriental", "code": "oriental"],
                                                      ["name" : "Pakistani", "code": "pakistani"],
                                                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                                                      ["name" : "Parma", "code": "parma"],
                                                      ["name" : "Persian/Iranian", "code": "persian"],
                                                      ["name" : "Peruvian", "code": "peruvian"],
                                                      ["name" : "Pita", "code": "pita"],
                                                      ["name" : "Pizza", "code": "pizza"],
                                                      ["name" : "Polish", "code": "polish"],
                                                      ["name" : "Portuguese", "code": "portuguese"],
                                                      ["name" : "Potatoes", "code": "potatoes"],
                                                      ["name" : "Poutineries", "code": "poutineries"],
                                                      ["name" : "Pub Food", "code": "pubfood"],
                                                      ["name" : "Rice", "code": "riceshop"],
                                                      ["name" : "Romanian", "code": "romanian"],
                                                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                                                      ["name" : "Rumanian", "code": "rumanian"],
                                                      ["name" : "Russian", "code": "russian"],
                                                      ["name" : "Salad", "code": "salad"],
                                                      ["name" : "Sandwiches", "code": "sandwiches"],
                                                      ["name" : "Scandinavian", "code": "scandinavian"],
                                                      ["name" : "Scottish", "code": "scottish"],
                                                      ["name" : "Seafood", "code": "seafood"],
                                                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                                                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                                                      ["name" : "Singaporean", "code": "singaporean"],
                                                      ["name" : "Slovakian", "code": "slovakian"],
                                                      ["name" : "Soul Food", "code": "soulfood"],
                                                      ["name" : "Soup", "code": "soup"],
                                                      ["name" : "Southern", "code": "southern"],
                                                      ["name" : "Spanish", "code": "spanish"],
                                                      ["name" : "Steakhouses", "code": "steak"],
                                                      ["name" : "Sushi Bars", "code": "sushi"],
                                                      ["name" : "Swabian", "code": "swabian"],
                                                      ["name" : "Swedish", "code": "swedish"],
                                                      ["name" : "Swiss Food", "code": "swissfood"],
                                                      ["name" : "Tabernas", "code": "tabernas"],
                                                      ["name" : "Taiwanese", "code": "taiwanese"],
                                                      ["name" : "Tapas Bars", "code": "tapas"],
                                                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                                                      ["name" : "Tex-Mex", "code": "tex-mex"],
                                                      ["name" : "Thai", "code": "thai"],
                                                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                                                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                                                      ["name" : "Trattorie", "code": "trattorie"],
                                                      ["name" : "Turkish", "code": "turkish"],
                                                      ["name" : "Ukrainian", "code": "ukrainian"],
                                                      ["name" : "Uzbek", "code": "uzbek"],
                                                      ["name" : "Vegan", "code": "vegan"],
                                                      ["name" : "Vegetarian", "code": "vegetarian"],
                                                      ["name" : "Venison", "code": "venison"],
                                                      ["name" : "Vietnamese", "code": "vietnamese"],
                                                      ["name" : "Wok", "code": "wok"],
                                                      ["name" : "Wraps", "code": "wraps"],
                                                      ["name" : "Yugoslav", "code": "yugoslav"]]
    
    let tableStructure: [PrefSectionIdentifier] = [ .OfferADeal , .Distance , .SortBy , .Category]
    
    let distanceStruct: Dictionary<Int ,String> = [0: "Auto",1: "0.3 mil", 2: "1 mil",  3: "5 km"]
    let sortByStruct: Dictionary<Int ,String> = [0: "Best matched",1: "Distance", 2: "Highest Rated"]
    
    
    
    
    var isShowedAllCategory : Bool!
    
    var switchStates: [Int:Bool]!
    
    var delegate: FiltersViewControllerDelegate!
    var isOfferAdealOn : Bool = defaults.bool(forKey: keyofferaDealSwitch) ?? false

    var pickgerValue : [[Int : String]] = [[5: "5km"], [10: "10 km"]]
    var isDistanceShow: Bool = false
    var isSortShow: Bool = false
    
    var defaultDistanceValue: String?
    var defaultSortValue:String = defaults.string(forKey: keyDefaulSort) ?? "Best matched"
    let searchSortModes: [YelpSortMode] = [.bestMatched, .distance ,.highestRated]
    var sortMode :YelpSortMode?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowedAllCategory = false
        let data = defaults.data(forKey: keyofdicswitchCategory)
        if let data = data {
            switchStates =  NSKeyedUnarchiver.unarchiveObject(with: data) as! [Int : Bool]
        }else{
            switchStates = [Int: Bool]()
        }
        defaultDistanceValue = defaults.string(forKey: keyDefaultDistance) ?? distanceStruct[0]
        
        tableView.dataSource = self
        tableView.delegate = self
        self.sortMode = self.searchSortModes[0]
        
        
        
    }
    
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        var filter = [String]()
        for (row , isSelected) in switchStates{
            if isSelected {
                filter.append(categories[row]["code"]!)
            }
        }
        
        let distance:Double? =  convertDistancetoMetter(defaultDistanceValue: defaultDistanceValue!)
        if filter.count > 0 {
            delegate.filtersVewController(filterVC: self, didupdateFilters: filter,isOfferADeal: isOfferAdealOn,sortMode: sortMode! , distance: distance)
            print("sortMode \(sortMode)")
        }
        
        
        let data = NSKeyedArchiver.archivedData(withRootObject: switchStates)
        defaults.set(data, forKey: keyofdicswitchCategory)

        defaults.set(defaultDistanceValue, forKey: keyDefaultDistance)
        defaults.set(defaultSortValue, forKey: keyDefaulSort)
        defaults.set(isOfferAdealOn, forKey: keyofferaDealSwitch)
        
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

extension FiltersViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getEachSectionCount(sectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        var filtersCell : FiltersCell!
        
        cell.delegate = self
        
        
        switch getSectionType(sectionIndex: indexPath.section) {
        case .OfferADeal:
            cell.settingFieldLable.text = "Offer a Deal"
            cell.switchButton.isOn = isOfferAdealOn
            break;
        case .Category:
            if !isShowedAllCategory && indexPath.row == 2 {
                let cellShowall = tableView.dequeueReusableCell(withIdentifier: "seeallCell") as! SeeallCell
                
                cellShowall.delegate = self
                return cellShowall
            }
            cell.settingFieldLable.text = categories[indexPath.row]["name"]
            cell.switchButton.isOn = switchStates[indexPath.row] ?? false
        case .Distance:
            filtersCell = tableView.dequeueReusableCell(withIdentifier: "filtersCell") as! FiltersCell
            if(indexPath.row) == 0{
                filtersCell.filterNameLable.text = defaultDistanceValue
                filtersCell.hiddencomboboxitemLable = true
                filtersCell.showPickerButton.isSelected = isDistanceShow
            }
            else{
                filtersCell.hiddencomboboxitemLable = false
                filtersCell.comboboxitemLable.text = distanceStruct[indexPath.row - 1]
            }
            filtersCell.delegate = self
            return filtersCell
        case .SortBy:
            filtersCell = tableView.dequeueReusableCell(withIdentifier: "filtersCell") as! FiltersCell
            if(indexPath.row) == 0{
                filtersCell.filterNameLable.text = defaultSortValue
                filtersCell.hiddencomboboxitemLable = true
                filtersCell.showPickerButton.isSelected = isSortShow
            }
            else{
                filtersCell.hiddencomboboxitemLable = false
                filtersCell.comboboxitemLable.text = sortByStruct[indexPath.row - 1]
            }
            filtersCell.delegate = self
            return filtersCell
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if getSectionType(sectionIndex: indexPath.section) == .Distance{
            if indexPath.row != 0{
            defaultDistanceValue = self.distanceStruct[indexPath.row - 1]!
            isDistanceShow = false
            }
            
        }else if getSectionType(sectionIndex: indexPath.section) == .SortBy{
            if indexPath.row != 0{
            defaultSortValue = self.sortByStruct[indexPath.row - 1]!
            isSortShow = false
            sortMode = searchSortModes[indexPath.row - 1]
            }
        }
        self.tableView.reloadData()
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableStructure[section].rawValue
    }
    
    
}




extension FiltersViewController: SwitchCellDelegate , FiltersCellDelegate , SeeallCellDelegate{
    
    
    
    fileprivate func getSectionType(sectionIndex: Int)->PrefSectionIdentifier{
        return tableStructure[sectionIndex]
    }
    
    fileprivate func getEachSectionCount(sectionIndex: Int) -> Int{
        switch  getSectionType(sectionIndex: sectionIndex) {
        case .OfferADeal:
            return 1
        case .Distance:
            if !isDistanceShow{
                return 1
            }
            return distanceStruct.count + 1
        case .SortBy:
            if !isSortShow{
                return 1
            }
            return sortByStruct.count + 1
        case .Category:
            if !isShowedAllCategory{
                return 3
            }
            return categories.count
        }
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
    func filtersCell(filtersCell: FiltersCell, didToogleButtonValueChange value: Bool) {
        let id = tableView.indexPath(for: filtersCell)
        if getSectionType(sectionIndex: (id?.section)!) == .Distance{
            isDistanceShow = value
        }
        else{
            isSortShow = value
        }
        tableView.reloadData()
        print("filtersCell(filtersCell")
    }
    
    func seeallCell(seallCell: SeeallCell) {
        isShowedAllCategory = true
        tableView.reloadData()
    }
    
    func convertDistancetoMetter(defaultDistanceValue: String) -> Double?{
        for (key, value) in distanceStruct{
            if(value == defaultDistanceValue){
                switch key{
                case 0 :
                    return nil
                case 1:
                    return milesTometers(speedInMPH: 0.3)
                case 2:
                    return milesTometers(speedInMPH: 1)
                case 3:
                    return milesTometers(speedInMPH: 5)
                default:
                    return nil
                }
                
            }
        }
        return nil
    }
    
}
