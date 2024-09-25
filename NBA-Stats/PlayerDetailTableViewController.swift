//
//  PlayerDetailTableViewController.swift
//  NBA-Stats
//
//  Created by Derek Stengel on 9/23/24.
//

//let detailVC = PlayerDetailTableViewController()
//detailVC.player = selectedPlayer // Pass the Player instance here
//navigationController?.pushViewController(detailVC, animated: true)

// add this code to navigate from PlayerDetailTableViewController and populate players properly

import UIKit

class PlayerDetailTableViewController: UITableViewController {
    var player: Player?
    
    var playerDetails: [(title: String, value: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let player = player else {
            print("Player is nil")
            return
        }
        
        playerDetails = [
            ("First Name", player.first_name ?? "No first name found"),
            ("Last Name", player.last_name ?? "No last name found"),
            ("Position", player.position ?? "Player Position Unavailable"),
            ("Height", player.height ?? "Could not find player height"),
            ("Weight", player.weight ?? "Could not find player weight"),
            ("Jersey Number", player.jersey_number ?? "N/A"),
            ("College", player.college ?? "N/A"),
            ("Country", player.country ?? "N/A"),
            ("Draft Year", player.draft_year != 0 ? "\(player.draft_year)" : "N/A"),
            ("Draft Round", player.draft_round != 0 ? "\(player.draft_round)" : "N/A"),
            ("Draft Number", player.draft_number != 0 ? "\(player.draft_number)" : "N/A")
        ]
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerDetail", for: indexPath)
        
        let detail = playerDetails[indexPath.row]
        cell.textLabel?.text = detail.title
        cell.detailTextLabel?.text = detail.value

        return cell
    }
    
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
