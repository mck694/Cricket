//
//  PlayersListVC.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 18/03/23.
//

import UIKit

class PlayersListVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var playersListTableView: UITableView!
    
    // MARK: - Properties
    var homeTeamPlayers: TeamValue? = nil

    var viewModel = TeamViewModel()
    var playerInforms = [Player]()
    
    var playerIsCaptain = [Bool]()
    var playerIsKeeper = [Bool]()
      
    var iccTrophy = [ICCTrophy]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    
    //MARK: - Initial Config Func
    func config() {
     
        var playersInfo = [String : Player]()
        playersInfo = homeTeamPlayers?.players ?? [:]
        
        for (_, value) in playersInfo {
            playerInforms.append(value)

            playerIsKeeper.append(value.iskeeper ?? false)
            playerIsCaptain.append(value.iscaptain ?? false)
        }

        
        iccTrophy.append(ICCTrophy(teamName: "\(homeTeamPlayers?.nameFull ?? "")", player: Array(playerInforms)))
    }
    
    
}


// MARK: - UITableViewDataSource
extension PlayersListVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return iccTrophy.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iccTrophy[section].player?.count ?? 0
        //        return playerInforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayersListCell
        
        cell.playerName.text = iccTrophy[indexPath.section].player?[indexPath.row].nameFull
 
        if playerIsKeeper[indexPath.row] == true {
            cell.isKeeper.isHidden = false
        } else { cell.isKeeper.isHidden = true }
        
        if playerIsCaptain[indexPath.row] == true {
            cell.isCaptian.isHidden = false
        } else { cell.isCaptian.isHidden = true }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let playerDetailVC = storyBoard.instantiateViewController(withIdentifier: "PlayerDetailVC") as! PlayerDetailVC
        playerDetailVC.playerInfo = iccTrophy[indexPath.section].player?[indexPath.row]
        self.navigationController?.pushViewController(playerDetailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return iccTrophy[section].teamName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor =  UIColor.systemCyan
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = iccTrophy[section].teamName
        view.addSubview(lbl)
        return view
    }
}




//MARK: - Model to differentiate Team A and Team B
class ICCTrophy {
    var teamName: String
    var player: [Player]?
    
    init(teamName: String, player: [Player]) {
        self.teamName = teamName
        self.player = player
    }
}


