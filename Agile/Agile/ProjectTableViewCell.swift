//
//  ProjectTableViewCell.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/7/22.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectDecriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
