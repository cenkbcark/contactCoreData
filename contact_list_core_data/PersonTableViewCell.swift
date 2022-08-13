//
//  PersonTableViewCell.swift
//  contact_list_core_data
//
//  Created by Cenk Bahadır Çark on 12.08.2022.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
