//
//  ResultCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(displayedData: DisplayedData) {
        propertyName.text = displayedData.name
        propertyValue.text = displayedData.value
    }
    
}
