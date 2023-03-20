//
//  PlayersListCell.swift
//  Cricket
//
//  Created by Manjunath C Kadani on 18/03/23.
//

import UIKit

class PlayersListCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var isCaptian: UILabel!
    @IBOutlet weak var isKeeper: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
