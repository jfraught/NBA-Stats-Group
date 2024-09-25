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

class PlayerDetailTableViewController: UITableViewController, UITextFieldDelegate {
    var player: Player?
    var playerDetails: [(title: String, value: String)] = []
    var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let player = player {
            self.navigationItem.title = "\(player.first_name ?? "") \(player.last_name ?? "")"
        } else {
            self.navigationItem.title = "Player Details"
        }
        
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
        
        if let savedNote = UserDefaults.standard.string(forKey: "note_\(player.id)") {
            note = savedNote
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return playerDetails.count
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerDetail", for: indexPath)
            
            let detail = playerDetails[indexPath.row]
            cell.textLabel?.text = detail.title
            cell.detailTextLabel?.text = detail.value
            cell.isUserInteractionEnabled = false
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") ?? UITableViewCell(style: .default, reuseIdentifier: "noteCell")
            let textFieldHeight: CGFloat = 45
            let textField = UITextField(frame: CGRect(x: 30, y: 0, width: cell.contentView.frame.width - 30, height: textFieldHeight))
            
            textField.placeholder = "Enter your note here"
            textField.text = note
            textField.delegate = self
            textField.tag = 1 // Use a tag to identify this text field later
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            cell.contentView.addSubview(textField)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 75
        }
        return UITableView.automaticDimension
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        note = textField.text ?? ""
        saveNote()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func saveNote() {
        // Save the note to UserDefaults using a unique key
        if let player = player {
            UserDefaults.standard.set(note, forKey: "note_\(player.id)")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Player Details" : "Player Note"
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
