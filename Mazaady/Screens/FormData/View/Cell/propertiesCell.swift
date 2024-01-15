//
//  propertiesCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit
import RxCocoa
import RxSwift
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown

class propertiesCell: UITableViewCell {
    @IBOutlet weak var propertyName: MDCOutlinedTextField!
    @IBOutlet weak var optionName: MDCOutlinedTextField!
    @IBOutlet weak var otherProperty: UITextField!
    @IBOutlet weak var propertyBtn: UIButton!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var optionsView: UIView!
    
    private let disposeBag = DisposeBag()
    let optionsDropDown = DropDown()
    let optionsChildsDropDown = DropDown()
    var properties:[Property] = []
    private var options:[Options] = []
    var didSelectChildOption: ((Int,Int,Int)->())?
    var otherValue:((String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        didTapProperty()
        didTapOnOptions()
        setUpTextFileds()
        optionName.sizeToFit()
        propertyName.sizeToFit()
        otherProperty.rx.text.orEmpty.filter({!$0.isEmpty}).subscribe(onNext: { [weak self] text in
            self?.otherValue?(text)
        }).disposed(by: disposeBag)
        
    }
    private func didTapProperty() {
        propertyBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.optionsDropDown.anchorView = self?.propertyBtn
            self?.optionsDropDown.show()
        }).disposed(by: disposeBag)
    }
    private func didTapOnOptions() {
        optionsBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.optionsChildsDropDown.anchorView = self?.optionsBtn
            self?.optionsChildsDropDown.show()
        }).disposed(by: disposeBag)
    }
    func didGetOptions(){
            self.optionsView.isHidden = false
            self.optionsChildsDropDown.dataSource =  options.map({$0.slug ?? ""})
           
    }
    private func setUpTextFileds(){
        self.optionName.label.text = "Select Options"
        optionsChildsDropDown.bottomOffset = CGPoint(x: 0, y:70)
        optionsDropDown.bottomOffset = CGPoint(x: 0, y:70)
        [propertyName,optionName].forEach { textFiled in
            textFiled.setOutlineColor(UIColor.DarkColor, for: .normal)
            textFiled.setOutlineColor(UIColor.DarkColor, for: .editing)
            textFiled.label.textColor = .red
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpCell(property: Property) {
       
        propertyName.label.text = property.name ?? ""
        let options = property.options ?? []
        let selectedOption = options.filter({$0.isSelected}).first
        handleSelectionOptionsChild(selectedOption: selectedOption, propertyId: property.id ?? 0)
        self.optionsDropDown.dataSource =  options.map({$0.slug ?? ""})
        self.propertyName.text = selectedOption?.slug
        if selectedOption?.slug == "Other" {
            self.otherProperty.isHidden = false
        }else {
            self.otherProperty.isHidden = true
        }
    }
    private func handleSelectionOptionsChild(selectedOption:Options?,propertyId:Int) {
        if !(selectedOption?.childsOptions?.isEmpty ?? true) {
            self.options = selectedOption?.childsOptions ?? []
            self.didGetOptions()
            let selectedChildOption = selectedOption?.childsOptions?.filter({$0.isSelected}).first
            self.optionName.text = selectedChildOption?.slug ?? ""
            self.optionsChildsDropDown.selectionAction = { [weak self] (index, item) in
                self?.optionName.text = item
                self?.didSelectChildOption?(index,selectedOption?.id ?? 0,propertyId)
        }
        }else {
            self.optionsView.isHidden = true
        }
    }
  
}
extension propertiesCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
