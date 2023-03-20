//
//  PlayerDetailVC.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 19/03/23.
//

import UIKit

class PlayerDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var battingStyle: UILabel!
    @IBOutlet weak var battingAverage: UILabel!
    @IBOutlet weak var battingStrikeRate: UILabel!
    @IBOutlet weak var battingRuns: UILabel!
    
    
    @IBOutlet weak var bowlingStyle: UILabel!
    @IBOutlet weak var bowlingAverage: UILabel!
    @IBOutlet weak var bowlingEconomyRate: UILabel!
    @IBOutlet weak var bowlingWickets: UILabel!
    
    
    // MARK: - Properties
    
    var playerInfo: Player?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        
    }
    
    // MARK: - Initial Config Screen
    
    func configureUI() {
        playerName.text = playerInfo?.nameFull ?? "No Name"
        
        battingStyle.text = "Style: " + (playerInfo?.batting.style.rawValue ?? "")
        
        battingAverage.text = "Average: " + (playerInfo?.batting.average ?? "")
        
        battingStrikeRate.text = "Strikerate: " + (playerInfo?.batting.strikerate ?? "")
        
        battingRuns.text = "Runs: " +  (playerInfo?.batting.runs ?? "")
        
        bowlingStyle.text = "Style: " +  (playerInfo?.bowling.style ?? "")
        bowlingAverage.text = "Average: " + (playerInfo?.bowling.average ?? "")
        bowlingEconomyRate.text = "Economyrate: " + (playerInfo?.bowling.economyrate ?? "")
        bowlingWickets.text = "Wickets: " + (playerInfo?.bowling.wickets ?? "")
    }
    

}
