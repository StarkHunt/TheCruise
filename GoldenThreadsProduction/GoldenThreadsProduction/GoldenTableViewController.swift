//
//  GoldenTableViewController.swift
//  GoldenThreadsProduction
//
//  Created by Sugat Nagavkar on 06/10/16.
//  Copyright © 2016 Sugat Nagavkar. All rights reserved.
//

import UIKit
//with view controller
class GoldenTableViewController : UITableViewController{
    
    var tableArray = ["Map", "Time Tables", "Alerts"]
    
    //function used to populate names in the table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
        
    }
    
    //function used to put number of cells in the table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
}
