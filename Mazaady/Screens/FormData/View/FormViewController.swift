//
//  FormViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 12/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class FormViewController: BaseViewController {
    @IBOutlet weak var propertiesTableView: DynmaicTableView!
    @IBOutlet weak var showData: UIButton!
    private let disposeBag = DisposeBag()
    var viewModel: FormViewModelProtocol?
    var router: FormRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        didTapOnShowData()
        configureSectionModel()
        registerTableViewCell()
        viewModel?.viewDidLoad()
    }
    private func setUpUI() {
        viewModel?.output.showLoading.asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    private func didTapOnShowData() {
        showData.rx.tap.bind(to: viewModel!.input.showDataTapped).disposed(by: disposeBag)
        viewModel?.output.displayedData.subscribe(onNext: {[weak self] displayedData in
            self?.router?.goToDisplayData(displayedData: displayedData)
        }).disposed(by: disposeBag)
    }
    private func configureSectionModel() {
        let dataSource = dataSource()
        viewModel?.output
            .section_Models
            .drive(propertiesTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    private func dataSource() -> RxTableViewSectionedReloadDataSource<CatigoriesSectionsModel> {
        return RxTableViewSectionedReloadDataSource<CatigoriesSectionsModel>(
            configureCell: { dataSource, tableView, indexPath, _ in
                switch dataSource[indexPath] {
                case let.MainCatigories(mainCatigories:mainCatigories):
                    return self.setUpMainCatigories(Categories: mainCatigories)
                case let.Properties(properties:properties):
                    return self.setUpPropertiesCell(propertis: properties)
                }
            })
    }
    
    private func setUpMainCatigories(Categories: [Categories])-> MainCatiogryCell {
        let cell = propertiesTableView.dequeueReusableCell(withIdentifier: "MainCatiogryCell") as!
        MainCatiogryCell
        cell.mainCatiogryProtcolDelegate = self
        cell.setUpCell(categories: Categories,subCatigories: viewModel!.output.subCatigories.value)
        cell.mainCatiogryProtcolDelegate = self
        return cell
    }
    
    private func setUpPropertiesCell(propertis: [Property])-> PropertyCell {
        let cell = propertiesTableView.dequeueReusableCell(withIdentifier: "PropertyCell") as!
        PropertyCell
        cell.setUpCell()
        cell.properties.accept(propertis)
        cell.propertiesProtocolDelegate = self
        self.showData.isHidden = propertis.isEmpty
        return cell
    }
    private func registerTableViewCell() {
        propertiesTableView.estimatedRowHeight = 200
        propertiesTableView.rowHeight = UITableView.automaticDimension
        propertiesTableView.register(UINib(nibName: "MainCatiogryCell", bundle: nil), forCellReuseIdentifier: "MainCatiogryCell")
        propertiesTableView.register(UINib(nibName: "PropertyCell", bundle: nil), forCellReuseIdentifier: "PropertyCell")
        propertiesTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}
extension FormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension FormViewController:propertiesProtocol{
    func didSetOtherValueForProperty(otherValue: String, propertyId: Int) {
        viewModel?.didSetOtherValueForProperty(otherValue: otherValue, propertyId: propertyId)
    }
    
    func didSelectChildOptions(at index: Int, optionID: Int, propertyId: Int) {
        viewModel?.didSelectChildOptions(at: index, optionID: optionID, propertyId: propertyId)
    }
    
    func didSelectOptions(at index: Int, propertyId: Int) {
        viewModel?.getChildsOptions(at: index, propertyId: propertyId)
    }
}
extension FormViewController:MainCatiogryProtcol{
    func didSelectMainCatigory(at index: Int) {
        viewModel?.getSubCatigriesForSelectedMainCatigory(selectedCatigoryIndex: index)
    }
    
    func didSelectSubCatigory(at index: Int) {
        viewModel?.getPropertiesForSelectedSubCatigoryAtIndex(Index: index)
    }
}
