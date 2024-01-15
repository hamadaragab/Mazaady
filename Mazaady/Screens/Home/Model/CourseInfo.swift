//
//  CourseInfo.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import Foundation
struct CourseInfo {
    var lessonNumber: Int
    var instructorJob: String
    var instructorName: String
    var instructorPhoto: String?
    var courseCost: String
    var courseName: String
    var time: String
    var title: String
    var courseImage: String?
    init(lessonNumber: Int, instructorJob: String, instructorName: String, instructorPhoto: String, courseCost: String, courseName: String, time: String, title: String, courseImage: String) {
        self.lessonNumber = lessonNumber
        self.instructorJob = instructorJob
        self.instructorName = instructorName
        self.instructorPhoto = instructorPhoto
        self.courseCost = courseCost
        self.courseName = courseName
        self.time = time
        self.title = title
        self.courseImage = courseImage
    }
}
