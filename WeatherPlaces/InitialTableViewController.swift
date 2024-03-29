//
//  InitialTableViewController.swift
//  WeatherPlaces
//
//  Created by Emil Iakoupov on 2019-11-21.
//  Copyright © 2019 Emil Iakoupov. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController, UISearchBarDelegate {

    var coreService: CoreDataService = CoreDataService()
    var locations: NSMutableArray = NSMutableArray()
    var selectedLocation: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchLocationsForText(name: searchText)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)

        cell.textLabel?.text = locations[indexPath.row] as! String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedLocation = locations[indexPath.row] as! String
        return indexPath
    }
    
    func fetchData() {
        locations.removeAllObjects()
        locations.addObjects(from: coreService.getSavedLocations() as! [Any])
    }
    
    func fetchLocationsForText(name: String) {
        locations.removeAllObjects()
        locations.addObjects(from: coreService.getSavedLocationsForName(name: name) as! [Any])
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let name = locations[indexPath.row]
            locations.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            coreService.removeLocationForName(name: name as! String)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }

  

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using
        if (segue.identifier == "details") {
            let dest: WeatherDetailsViewController = segue.destination as! WeatherDetailsViewController
            dest.location = selectedLocation
        } else if (segue.identifier == "locationSearch") {
            let dest: WheatherSearchTableViewController = segue.destination as! WheatherSearchTableViewController
            func onBack () {
                self.fetchData()
                self.tableView.reloadData()
            }
            dest.onBack = onBack
        }
        // Pass the selected object to the new view controller.
    }

}
