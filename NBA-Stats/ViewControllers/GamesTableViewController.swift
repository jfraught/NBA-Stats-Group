//
//  GamesTableViewController.swift
//  NBA-Stats
//
//  Created by Jordan Fraughton on 9/25/24.
//

import UIKit
import CoreData

class GamesTableViewController: UITableViewController {
    var games: [Game] = []
    
    var isSelected: Bool = false // use this when we impliment stars / favorites to the cells in storyboard
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        tableView.reloadData()
    //        Task {
    //            do {
    //                games = try await DataController.getGames()
    //                if games.isEmpty {
    //                    games = Game.mockGames
    //                }
    //                tableView.reloadData()
    //            } catch let error as URLError {
    //                print("SSL error occured \(error)")
    //                games = Game.mockGames
    //                tableView.reloadData()
    //            } catch {
    //                print("An error occured \(error)")
    //                games = Game.mockGames
    //                tableView.reloadData()
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        Task {
            do {
                games = try await DataController.getGames()
                if games.isEmpty {
                    games = Game.mockGames(in: context) // Use mock data if no games are returned
                }
                tableView.reloadData()
            } catch let error as URLError {
                print("SSL error occurred: \(error)")
                games = Game.mockGames(in: context) // Use mock data in case of an error
                tableView.reloadData()
            } catch {
                print("An error occurred: \(error)")
                games = Game.mockGames(in: context) // Use mock data in case of an error
                tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Upcoming Games"
        case 1:
            return "Ongoing Games"
        case 2:
            return "Completed Games"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3 // past
        case 1:
            return 3 // current
        case 2:
            return 3 // future
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        guard games.count >= 9 else {
            cell.textLabel?.text = "Game data not available"
            return cell
        }
        
        let game: Game
        
        switch indexPath.section {
        case 0:
            game = games[indexPath.row] // past
        case 1:
            game = games[indexPath.row + 3] // current
        case 2:
            game = games[indexPath.row + 6] // future
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
        
        let homeTeam = game.homeTeam ?? "Unknown Home Team"
        let visitorTeam = game.visitorTeam ?? "Unknown Visitor Team"
        
        cell.textLabel?.text = "\(homeTeam) vs \(visitorTeam)"
        
        return cell
    }
    
    
    
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
