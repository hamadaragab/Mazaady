//
//  HomeViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol HomeViewModelProtocol: AnyObject {
    var input: HomeViewModel.Input {get}
    var output: HomeViewModel.Output {get}
    func viewDidLoad()
    func getStringSize(at index: Int)->CGFloat
    func didSelectCourse(at index: Int)
}
class HomeViewModel:HomeViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    let storiesImage = ["story1","story2","story3","story4"]
    var courses:[CourseData] = [CourseData(name: "All", isSelected: true),CourseData(name: "UI/UX", isSelected: false),CourseData(name: "Illustration", isSelected: false),CourseData(name: "3D Animation", isSelected: false)]
    var upcomingCourses:[CourseInfo] = []
    
    func viewDidLoad(){
        setDummyDataForupcomingCourses() 
        output.courses.onNext(courses)
        output.stories.onNext(storiesImage)
    }
    private func setDummyDataForupcomingCourses() {
        upcomingCourses = [CourseInfo(lessonNumber: 6, instructorJob: "Product Designer", instructorName: "Laurel Seilha", instructorPhoto: "profile2", courseCost: "Free", courseName: "ui ux", time: "5h 21m", title: "Step design sprint for beginner", courseImage: "course1"),CourseInfo(lessonNumber: 8, instructorJob: "Programmer", instructorName: "AHmed Mohammed", instructorPhoto: "profileImage", courseCost: "123 $", courseName: "Swift", time: "10h 44m", title: "First Step  for beginner", courseImage: "course1")
        ]
        output.upcommingCourses.onNext(upcomingCourses)
    }
    func getStringSize(at index: Int)->CGFloat {
        return courses[index].name.width
    }
    func didSelectCourse(at index: Int) {
        for i in 0..<courses.count {
            if i == index{
                courses[i].isSelected = true
            }else {
                courses[i].isSelected = false
            }
        }
        output.courses.onNext(courses)
    }
}

extension HomeViewModel: BaseViewModel {
    struct Input {
    }
    class Output {
        let stories = PublishSubject<[String]>()
        let courses = PublishSubject<[CourseData]>()
        let upcommingCourses = PublishSubject<[CourseInfo]>()
    }
    
}
