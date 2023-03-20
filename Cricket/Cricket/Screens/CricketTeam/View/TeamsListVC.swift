//
//  TeamsListVC.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 18/03/23.
//

import UIKit

enum TeamAorB {
    case teamHome, teamAway
}

class TeamsListVC: UIViewController {
    

    // MARK: - IBOutlets
    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    
    @IBOutlet weak var teamAView: UIView!
    @IBOutlet weak var teamBView: UIView!
    
    @IBOutlet weak var teamAImageView: UIImageView!
    @IBOutlet weak var teamBImageView: UIImageView!
    
    
    // MARK: - Properties
    var viewModel = TeamViewModel()
    var teamHome = TeamAorB.teamHome
    var teamAway = TeamAorB.teamAway

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    
    // Func to get teamName from API
        
    func getTeamInfo(team : TeamAorB) -> String? {
        if team == TeamAorB.teamHome {
            return self.viewModel.team?.matchdetail.teamHome ?? ""
        } else {
            return self.viewModel.team?.matchdetail.teamAway ?? ""
        }
    }
    
    // Func to set TeamLogo based on API
    func getTeamLogo(team: TeamAorB) -> String? {
        if team == TeamAorB.teamHome {
            return "NewZealandLogo"
        } else {
            return "IndiaLogo"
            
            
        }
    }
    
    
    // Configuration Func
    func configureUI() {
       
        let teamNamesDictionory = self.viewModel.team?.teams ?? [:]
        
        let homeTeamPlayers = self.viewModel.team?.teams["\(getTeamInfo(team: TeamAorB.teamHome) ?? "")"]
        
        let awayTeamPlayers = self.viewModel.team?.teams["\(getTeamInfo(team: TeamAorB.teamAway) ?? "")"]

        // Set Team Name from API
        teamA.text = homeTeamPlayers!.nameFull
        teamB.text = awayTeamPlayers!.nameFull
        
        
        
        let homeTeamLogo = getTeamLogo(team: TeamAorB.teamHome)
       
        let awayTeamLogo = getTeamLogo(team: TeamAorB.teamAway)
        
        // Set Team Logo from API
        teamAImageView.image = UIImage(named: homeTeamLogo ?? "")
        teamBImageView.image = UIImage(named: awayTeamLogo ?? "")
        
        
        // Tap Gesture For Team A
        let tapTeamA = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTeamA(_:)))
        
        teamAView.addGestureRecognizer(tapTeamA)
        
        teamAView.isUserInteractionEnabled = true
        

        
        // Tap Gesture For Team B
        let tapTeamB = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTeamB(_:)))
        
        teamBView.addGestureRecognizer(tapTeamB)
        
        teamBView.isUserInteractionEnabled = true
        
        
    }
    
    // @objc func For Team A Tap
    @objc func handleTapTeamA(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let playerstVC = storyBoard.instantiateViewController(withIdentifier: "PlayersListVC") as! PlayersListVC
        playerstVC.viewModel = viewModel
        let homeTeamPlayers = self.viewModel.team?.teams["\(getTeamInfo(team: TeamAorB.teamHome) ?? "")"]
        playerstVC.homeTeamPlayers = homeTeamPlayers
        self.navigationController?.pushViewController(playerstVC, animated: true)
    }
    // @objc func For Team B Tap
    @objc func handleTapTeamB(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let playerstVC = storyBoard.instantiateViewController(withIdentifier: "PlayersListVC") as! PlayersListVC
        let awayTeamPlayers = self.viewModel.team?.teams["\(getTeamInfo(team: TeamAorB.teamAway) ?? "")"]
        playerstVC.homeTeamPlayers = awayTeamPlayers
        self.navigationController?.pushViewController(playerstVC, animated: true)
    }
    

}
