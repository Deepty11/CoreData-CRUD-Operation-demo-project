//
//  TableViewCell.swift
//  CoreDataTestApp
//
//  Created by Brotecs on 13/1/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
