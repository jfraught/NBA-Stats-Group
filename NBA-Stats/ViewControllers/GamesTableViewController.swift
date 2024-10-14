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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        Task {
            do {
                games = try await DataController.getGames()
                if games.isEmpty {
                    games = Game.mockGames(in: context)
                }
                tableView.reloadData()
            } catch let error as URLError {
                print("SSL error occurred: \(error)")
                games = Game.mockGames(in: context)
                tableView.reloadData()
            } catch {
                print("An error occurred: \(error)")
                games = Game.mockGames(in: context)
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
            return 3
        case 1:
            return 3
        case 2:
            return 3
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
            game = games[indexPath.row]
        case 1:
            game = games[indexPath.row + 3]
        case 2:
            game = games[indexPath.row + 6]
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
        
        let homeTeam = game.homeTeam ?? "Unknown Home Team"
        let visitorTeam = game.visitorTeam ?? "Unknown Visitor Team"
        
        cell.textLabel?.text = "\(homeTeam) vs \(visitorTeam)"
        
        return cell
    }
}
