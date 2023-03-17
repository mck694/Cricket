//
//  MatchInfoHomeScreenVC.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 17/03/23.
//

import UIKit

class MatchInfoHomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.fetchMatchDetails { response in
            switch response {
            case .success(let team):
                print(team)
            case .failure(let error):
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
