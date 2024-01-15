//
//  AdvertizingCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import UIKit

class CourseInfoCell: UICollectionViewCell {
    @IBOutlet weak var lessonNumber: UILabel!
    @IBOutlet weak var ibstructorJob: UILabel!
    @IBOutlet weak var instructName: UILabel!
    @IBOutlet weak var instructorPhoto: UIImageView!
    @IBOutlet weak var courseCost: UILabel!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        [courseName,courseCost,lessonNumber].forEach { label in
            label?.adjustsFontSizeToFitWidth = true
        }
    }
    func setUpCell(courseInfo:CourseInfo) {
        lessonNumber.text = " \(courseInfo.lessonNumber) lesssons "
        ibstructorJob.text =  courseInfo.instructorJob
        instructName.text =  courseInfo.instructorName
        courseCost.text =  " \(courseInfo.courseCost) "
        courseName.text =  " \(courseInfo.courseName) "
        time.text =  courseInfo.time
        titleLBL.text =  courseInfo.title
        courseImage.image = UIImage(named: courseInfo.courseImage ?? "")
        instructorPhoto.image = UIImage(named: courseInfo.instructorPhoto ?? "")

    }
}
