//
//  TableViewCell.swift
//  Bottle
//
//  Created by 有田栄乃祐 on 2020/10/20.
//  Copyright © 2020 artApps. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var yearKeepLabel: UILabel!
    @IBOutlet weak var monthKeepLabel: UILabel!
    @IBOutlet weak var dayKeepLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberLabel.layer.cornerRadius = 12
        customerLabel.layer.cornerRadius = 12
        remainLabel.layer.cornerRadius = 12
        yearKeepLabel.layer.cornerRadius = 12
        monthKeepLabel.layer.cornerRadius = 12
        dayKeepLabel.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
