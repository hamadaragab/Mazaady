//
//  DisplayDataViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class DisplayDataViewController: UIViewController {
    @IBOutlet weak var propertiesTableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    private let disposeBag = DisposeBag()
    var viewModel: DisplayDataViewModelProtocol?
     var router: DisplayDataRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableViewData()
        registerCell()
        didTapOnCloseBtn()
        viewModel?.viewDidLoad()
    }
    private func didTapOnCloseBtn() {
        closeBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.dismiss()
        }).disposed(by: disposeBag)
    }
    private func registerCell() {
        propertiesTableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        propertiesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    private func bindTableViewData() {
        viewModel?.output.displayedData.bind(to: propertiesTableView.rx.items(cellIdentifier: "ResultCell",cellType: ResultCell.self)) {(index,displayedData,cell) in
            cell.setUpCell(displayedData: displayedData)
        }.disposed(by: disposeBag)
    }

}
extension DisplayDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
