//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD
class BusinessesViewController: UIViewController {

    var businesses: [Business]!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noresultWarningLable: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noresultWarningLable.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        refreshControl.addTarget(self, action: #selector(self.fetchData), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        fetchData()
        
        }
    
    func fetchData(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
                self.noResultDisplayMessage(isshowNoResultMessageShow: false)
                
                if businesses.count == 0 {
                    self.noResultDisplayMessage(isshowNoResultMessageShow: true)
                }else{
                    self.noResultDisplayMessage(isshowNoResultMessageShow: false)
                }
            }
            self.refreshControl.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let naVC = segue.destination as! UINavigationController
        let filterVC = naVC.topViewController as! FiltersViewController
        filterVC.delegate = self
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource , FiltersViewControllerDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses == nil{
            return 0
        }else{
            return businesses.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
        
    }
    
    func filtersVewController(filterVC: FiltersViewController, didupdateFilters filters: [String],isOfferADeal: Bool , sortMode: YelpSortMode, distance: Double?){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "", sort: sortMode, categories: filters, deals: isOfferADeal, distance: distance ) { (business:
            [Business]?, error: Error?) in
            
            if let business = business{
                self.businesses = business
                self.tableView.reloadData()
                if business.count == 0{
                    self.noResultDisplayMessage(isshowNoResultMessageShow: true)
                }else{
                    self.noResultDisplayMessage(isshowNoResultMessageShow: false)
                }
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var filter = [String]()
        filter.append(searchBar.text!)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: searchBar.text! ){(business: [Business]?,error: Error?) in
            if let business = business{
                self.businesses.removeAll()
                self.businesses = business
                self.tableView.reloadData()
                if business.count == 0 {
                    self.noResultDisplayMessage(isshowNoResultMessageShow: true)
                }else{
                    self.noResultDisplayMessage(isshowNoResultMessageShow: false)
                }
            }
            
            searchBar.resignFirstResponder()
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
        self.searchBar.endEditing(true)
    }
    fileprivate func noResultDisplayMessage(isshowNoResultMessageShow: Bool){
        self.noresultWarningLable.isHidden = !isshowNoResultMessageShow
        self.tableView.isHidden = isshowNoResultMessageShow
    
    }
}
