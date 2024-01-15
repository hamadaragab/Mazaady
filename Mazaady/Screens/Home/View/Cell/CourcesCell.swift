//
//  CourcesCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import UIKit

class CourcesCell: UICollectionViewCell {
    @IBOutlet weak var courseName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(courseData: CourseData){
        self.courseName.text = courseData.name
        if courseData.isSelected {
                courseName.textColor = .white
                contentView.backgroundColor = UIColor(named: "mainColor")
            }else {
                courseName.textColor = .darkText
                contentView.backgroundColor = UIColor(named: "DarkColor")
            }
    }
}
