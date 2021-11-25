//
//  CatListCell.swift
//  CatAPITestProject
//
//  Created by Евгений on 25.11.21.
//

import UIKit

class CatListCell: UITableViewCell {

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        catImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
