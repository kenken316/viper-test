//
//  TableViewCell.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    func setRepository(_ repository: Repository) {
        repositoryNameLabel.text = repository.fullName
//        starCoutLabel.text = "\(repository.starCount)"
    }

}
