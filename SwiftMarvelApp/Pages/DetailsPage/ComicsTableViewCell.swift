//
//  ComicsTableViewCell.swift
//  SwiftMarvelApp
//
//  Created by Furkan Özyürek on 16.01.2022.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblComicName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
