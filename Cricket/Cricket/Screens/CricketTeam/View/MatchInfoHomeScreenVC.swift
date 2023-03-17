//
//  MatchInfoHomeScreenVC.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 17/03/23.
//

import UIKit

class MatchInfoHomeScreenVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var teamA: UILabel!
    
    @IBOutlet weak var teamB: UILabel!
    
    @IBOutlet weak var matchCardView: UIView!
    
    
    // MARK: - Properties
    private var viewModel = TeamViewModel()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}

extension MatchInfoHomeScreenVC {
    
    func configuration() {
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchMatchInfo()
    }
    
    //Data Binding
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator Show
                print("Team Loading ..... ")
            case .dataLoaded:
                print("Teams Loaded ..... ")
                
                DispatchQueue.main.async {
                    self.configureUI()
                    
                }
            case .stopLoading:
                //Indicator Stop
                print("Stop Team Loading ..... ")
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    func configureUI() {
        //Venue Name
        let venueName = self.viewModel.team?.matchdetail.venue.name
        self.venueLabel.text = "Venue:" + " " + ( venueName ?? "")
        
        // Day
        let day =  self.viewModel.team?.matchdetail.match.date ?? ""
        // Time
        let matchTime = self.viewModel.team?.matchdetail.match.time ?? ""
        
        self.dateTimeLabel.text = self.viewModel.matchDay(dayTime: day) + "   " + self.viewModel.matchTime(dateTime: matchTime)
        
        
        var teamNamesDictionory = self.viewModel.team?.teams ?? [:]
        //Team A Name
        var teamAInteamNamesDictionory = self.viewModel.teamNames(teamName: teamNamesDictionory , at: 0)
        //Team B Name
        var teamBInteamNamesDictionory = self.viewModel.teamNames(teamName: teamNamesDictionory , at: 1)
        
        teamA.text = teamAInteamNamesDictionory
        teamB.text = teamBInteamNamesDictionory
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        matchCardView.addGestureRecognizer(tap)
        
        matchCardView.isUserInteractionEnabled = true
        
        self.view.addSubview(matchCardView)
        
        
        
    }
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    
    
}
}
