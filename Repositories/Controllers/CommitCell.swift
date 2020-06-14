//
//  CommitCell.swift
//  Repositories
//
//  Created by Elizeus on 13/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit

class CommitCell: UITableViewCell {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func setLabel(commitData: CommitItem){
        messageLabel.text = commitData.commit.message
        nameLabel.text = commitData.commit.committer.name
        dateLabel.text = commitData.commit.author.date
    }
}
