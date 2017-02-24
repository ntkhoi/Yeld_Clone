//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    var businesses: [Business]!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
                
            }
        }
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let naVC = segue.destination as! UINavigationController
        let filterVC = naVC.topViewController as! FiltersViewController
        filterVC.delegate = self
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource , FiltersViewControllerDelegate {
    
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
    
    func filtersVewController(filterVC: FiltersViewController, didupdateFilters filters: [String]) {
        Business.search(with: "", sort: nil, categories: filters, deals: nil ) { (business: [Business]?, error: Error?) in
            if let business = business{
                self.businesses = business
                self.tableView.reloadData()
            }
        }
    }
}
