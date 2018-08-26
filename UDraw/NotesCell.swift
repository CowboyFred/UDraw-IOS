//
//  NotesCell.swift
//  UDraw
//
//  Created by Denis Eltcov on 5/8/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var usersImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
