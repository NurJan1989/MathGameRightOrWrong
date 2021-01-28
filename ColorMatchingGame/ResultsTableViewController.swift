//
//  ResultsTableViewController.swift
//  ColorMatchingGame
//
//  Created by Macbook Air on 12/3/20.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var results: [String] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let corrects = UserDefaults.standard.stringArray(forKey: "results") {
            results = corrects
        }
     
        
        results.sort() { $0 > $1}
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultTableViewCell
        cell.titleLabel2.text = results[indexPath.row]
        cell.titleLabel.text = ("№ \((indexPath.row + 1).description)")
      
        return cell
    }
    
    @IBAction func cleareButton(_ sender: UIBarButtonItem) {
        UserDefaults.standard.setValue(nil, forKey: "results")
        results = []
        tableView.reloadData()
    }
}
