//
//  MainCatiogryCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import UIKit
import DropDown
import RxSwift
import RxCocoa
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
protocol MainCatiogryProtcol: AnyObject {
    func didSelectMainCatigory(at index: Int)
    func didSelectSubCatigory(at index: Int)
}
class MainCatiogryCell: UITableViewCell {
    
    @IBOutlet weak var mainCatigoryBtn: UIButton!
    @IBOutlet weak var subCatigoryBtn: UIButton!
    @IBOutlet weak var subCatigoryTxt: MDCOutlinedTextField!
    @IBOutlet weak var mainCatigoryTxt: MDCOutlinedTextField!
    weak var mainCatiogryProtcolDelegate: MainCatiogryProtcol?
    
    private let disposeBag = DisposeBag()
    private var mainCatigories:[Categories] = []
    private var subCatigories:[Children] = []
    let mainCatigoriesdropDown = DropDown()
    let subCatigoriesdropDown = DropDown()
    override func awakeFromNib() {
        super.awakeFromNib()
        didSelectSubCatigory()
        didSelectMainCatigory()
        setUpTextFileds()
        setUpUi()
        // Initialization code
    }
    private func setUpTextFileds(){
        mainCatigoryTxt.label.text = "Main Catigory"
        mainCatigoryTxt.setOutlineColor(UIColor.DarkColor, for: .normal)
        mainCatigoryTxt.setOutlineColor(UIColor.DarkColor, for: .editing)
        subCatigoryTxt.label.text = "Sub Catigory"
        subCatigoryTxt.setOutlineColor(UIColor.DarkColor, for: .normal)
        subCatigoryTxt.setOutlineColor(UIColor.DarkColor, for: .editing)
    }
    private func setUpUi() {
        mainCatigoriesdropDown.bottomOffset = CGPoint(x: 0, y:70)
        subCatigoriesdropDown.bottomOffset = CGPoint(x: 0, y:70)
        mainCatigoriesdropDown.anchorView = mainCatigoryBtn
        subCatigoriesdropDown.anchorView = subCatigoryBtn
    }
    private func didSelectMainCatigory() {
        mainCatigoryBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            let catigoriesName = self?.mainCatigories.map({$0.name ?? ""})
            self?.mainCatigoriesdropDown.dataSource = catigoriesName ?? []
            self?.mainCatigoriesdropDown.show()
        }).disposed(by: disposeBag)
        mainCatigoriesdropDown.selectionAction = {[weak self] (index, item) in
            self?.mainCatigoryTxt.text = item
            self?.subCatigoryTxt.text = ""
            self?.mainCatiogryProtcolDelegate?.didSelectMainCatigory(at: index)
        }
    }
    private func didSelectSubCatigory() {
        subCatigoryBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            let catigoriesName = self?.subCatigories.map({$0.name ?? ""})
            self?.subCatigoriesdropDown.dataSource = catigoriesName ?? []
            self?.subCatigoriesdropDown.show()
        }).disposed(by: disposeBag)
        subCatigoriesdropDown.selectionAction = {[weak self] (index, item) in
            self?.subCatigoryTxt.text = item
            self?.mainCatiogryProtcolDelegate?.didSelectSubCatigory(at: index)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpCell(categories: [Categories],subCatigories: [Children]){
        self.mainCatigories = categories
        self.subCatigories = subCatigories
    }
    
}
