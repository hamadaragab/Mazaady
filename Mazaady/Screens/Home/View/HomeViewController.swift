//
//  HomeViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class HomeViewController: UIViewController {
    @IBOutlet weak var StroyCollectionView: UICollectionView!
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    @IBOutlet weak var upCommingCoursesCollectionView: UICollectionView!

    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModelProtocol?
     var router: HomeRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpUpCommingCoursesCollectionView()
        setUpCoursesCollectionView()
        setUpStroyCollectionView()
        viewModel?.viewDidLoad()

    }
    private func registerCell() {
        StroyCollectionView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: "StoryCell")
        coursesCollectionView.register(UINib(nibName: "CourcesCell", bundle: nil), forCellWithReuseIdentifier: "CourcesCell")
        upCommingCoursesCollectionView.register(UINib(nibName: "AdvertizingCell", bundle: nil), forCellWithReuseIdentifier: "AdvertizingCell")
        StroyCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        coursesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        upCommingCoursesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func setUpStroyCollectionView() {
        viewModel?.output.stories.bind(to: StroyCollectionView.rx.items(cellIdentifier: "StoryCell",cellType: StoryCell.self)){(index,story,cell) in
            cell.setUpCell(imageName: story)
        }.disposed(by: disposeBag)
    }
    private func setUpCoursesCollectionView() {
        viewModel?.output.courses.bind(to: coursesCollectionView.rx.items(cellIdentifier: "CourcesCell",cellType: CourcesCell.self)){(index,course,cell) in
            cell.setUpCell(courseData: course)
        }.disposed(by: disposeBag)
        coursesCollectionView.rx.itemSelected.subscribe(onNext:{[weak self] indexPath in
            self?.viewModel?.didSelectCourse(at: indexPath.row)
        }).disposed(by: disposeBag)
    }
    private func setUpUpCommingCoursesCollectionView() {
        viewModel?.output.upcommingCourses.bind(to: upCommingCoursesCollectionView.rx.items(cellIdentifier: "AdvertizingCell",cellType: CourseInfoCell.self)){(index,course,cell) in
            cell.setUpCell(courseInfo: course)
        }.disposed(by: disposeBag)
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == StroyCollectionView {
            return CGSize(width: (collectionView.bounds.size.width) / 3.5, height: 75)
        }else if collectionView == coursesCollectionView{
            let width = viewModel?.getStringSize(at: indexPath.row) ?? 0.0
            return  CGSize(width:width, height: 40)
        }else {
            return CGSize(width:(collectionView.bounds.size.width) / 1.1, height: collectionView.bounds.size.height)
        }
    }
}
