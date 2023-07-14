//
//  AttractionTableViewCell.swift
//  TableViewStory
//
//  Created by james on 27/04/2023.
//

import UIKit

class AttractionTableViewCell: UITableViewCell {

    @IBOutlet weak var attractionLabel: UILabel!
    @IBOutlet weak var attractionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
