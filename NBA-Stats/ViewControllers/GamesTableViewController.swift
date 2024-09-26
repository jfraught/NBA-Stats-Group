//
//  GamesTableViewController.swift
//  NBA-Stats
//
//  Created by Jordan Fraughton on 9/25/24.
//

import UIKit

class GamesTableViewController: UITableViewController {
    var game: Game?
    
    var todaysGames: [Game] = [( "Game 1", "Game 2", "Game 3", "Game 4", "Game 5", "Game 6", "Game 7", "Game 8", "Game 9", "Game 10", "Game 11", "Game 12", "Game 13", "Game 14", "Game 15", "Game 16", "Game 17", "Game 18", "Game 19", "Game 20", "Game 21", "Game 22", "Game 23", "Game 24", "Game 25", "Game 26", "Game 27", "Game 28", "Game 29", "Game 30", "Game 31", "Game 32", "Game 33", "Game 34", "Game 35", "Game 36", "Game 37", "Game 38", "Game 39", "Game 40", "Game 41", "Game 42", "Game 43", "Game 44", "Game 45", "Game 46", "Game 47", "Game 48", "Game 49", "Game 50", "Game 51", "Game 52", "Game 53", "Game 54", "Game 55", "Game 56", "Game 57", "Game 58", "Game 59", "Game 60", "Game 61", "Game 62", "Game 63", "Game 64", "Game 65", "Game 66", "Game 67", "Game 68", "Game 69", "Game 70", "Game 71", "Game 72", "Game 73", "Game 74", "Game 75", "Game 76", "Game 77", "Game 78", "Game 79", "Game 80", "Game 81", "Game 82", "Game 83", "Game 84", "Game 85", "Game 86", "Game 87", "Game 88", "Game 89", "Game 90", "Game 91", "Game 92", "Game 93", "Game 94", "Game 95", "Game 96", "Game 97", "Game 98", "Game 99", "Game 100", "Game 101", "Game 102", "Game 103", "Game 104", "Game 105", "Game 106", "Game 107", "Game 108", "Game 109", "Game 110", "Game 111", "Game 112", "Game 113", "Game 114", "Game 115", "Game")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let game = game else {
            print("Game is nil")
            return
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
        

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
