//
//  TeamViewModel.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 17/03/23.
//

import Foundation

final class TeamViewModel {
    
    var team: Team?
    
    //Data Binding using Closure
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchMatchInfo() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchMatchDetails { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let team):
                self.team = team
                self.eventHandler?(.dataLoaded)

            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error)
            }
        }
    }
    
    
    // Date and Time Formatter from API
    func matchTime(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateTime)
        dateFormatter.dateFormat = "h:mm a"
        
        let date12Hour = dateFormatter.string(from: date!)
        
        return date12Hour
    }
    // Date and Time Formatter from API
    func matchDay(dayTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let date = dateFormatter.date(from: dayTime)
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let date12Hour = dateFormatter.string(from: date!)
        
        return date12Hour
    }
    
    
    // To fetch Team Names
    func teamNames(teamName: [String: TeamValue], at index: Int) -> String {
        var teamNameArray = [String]()
        for (_, value) in teamName {

            teamNameArray.append(value.nameFull)
        }
        let sortedArray = teamNameArray.sorted(by: <)
        
        return sortedArray[index]
    }
    
    func playerNames(playName: [String: TeamValue]) -> [String:Player] {

        var playerDict = [String:Player]()
        for (_, value) in playName {

            playerDict = value.players
        }
        return playerDict
    }
    
}

// Data Binding
extension TeamViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(_ error: Error)
    }
}
