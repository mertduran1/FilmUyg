//
//  SearchTableViewCell.swift
//  FilmUyg
//
//  Created by Mert Duran on 22.06.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellVote: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellName: UILabel!
    
    @IBOutlet weak var cellDate: UILabel!
    
    @IBOutlet weak var cellView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
