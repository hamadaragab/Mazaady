//
//  StoryCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit

class StoryCell: UICollectionViewCell {
    @IBOutlet weak var StroyImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(imageName: String){
        StroyImage.image = UIImage(named: imageName)
    }

}
