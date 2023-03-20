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
    
    @IBOutlet weak  var teamAImageView: UIImageView!
    
    @IBOutlet weak  var teamBImageView: UIImageView!
    
    @IBOutlet weak var teamB: UILabel!
    
    @IBOutlet weak var matchCardView: UIView!
    
    
    // MARK: - Properties
    private var viewModel = TeamViewModel()
    
    var activityView: UIActivityIndicatorView?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        self.showActivityIndicator()
        matchCardView.isHidden = true
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
                DispatchQueue.main.async {
                    self.showActivityIndicator()
                }
                
                print("Team Loading ..... ")
            case .dataLoaded:
                print("Teams Loaded ..... ")
                
                DispatchQueue.main.async {
                    self.configureUI()
                    
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.matchCardView.isHidden = false
                    self.hideActivityIndicator()
                }
                
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
        
        
        let teamNamesDictionory = self.viewModel.team?.teams ?? [:]
        //Team A Name
        let teamAInteamNamesDictionory = self.viewModel.teamNames(teamName: teamNamesDictionory , at: 0)
        //Team B Name
        let teamBInteamNamesDictionory = self.viewModel.teamNames(teamName: teamNamesDictionory , at: 1)
        
        teamA.text = teamAInteamNamesDictionory
        teamB.text = teamBInteamNamesDictionory
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        matchCardView.addGestureRecognizer(tap)
        
        matchCardView.isUserInteractionEnabled = true
        
        self.view.addSubview(matchCardView)
                    
    }
    
    func showActivityIndicator() {
                
        let container: UIView = UIView()
            container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = UIColor.clear
            
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.center = self.view.center
            
            container.addSubview(activityView)
            self.view.addSubview(container)
            activityView.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let teamsListVC = storyBoard.instantiateViewController(withIdentifier: "TeamsListVC") as! TeamsListVC
        teamsListVC.viewModel = viewModel
        self.navigationController?.pushViewController(teamsListVC, animated: true)
    }
}
