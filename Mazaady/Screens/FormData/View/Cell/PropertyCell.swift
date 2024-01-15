//
//  PropertyCell.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
protocol propertiesProtocol: AnyObject {
    func didSelectOptions(at index: Int,propertyId: Int)
    func didSelectChildOptions(at index: Int,optionID:Int,propertyId: Int)
    func didSetOtherValueForProperty(otherValue:String,propertyId: Int)
}
class PropertyCell: UITableViewCell {
    @IBOutlet weak var propertiesTableView: DynmaicTableView!
    weak var propertiesProtocolDelegate:propertiesProtocol?
    private let disposeBag = DisposeBag()
    let properties = BehaviorRelay<[Property]>(value: [])
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpPropertyTableView()
        
        // Initialization code
    }
    private func setUpPropertyTableView(){
        propertiesTableView.estimatedRowHeight = 60
        propertiesTableView.rowHeight = UITableView.automaticDimension
        propertiesTableView.register(UINib(nibName: "propertiesCell", bundle: nil), forCellReuseIdentifier: "propertiesCell")
        propertiesTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(){
        propertiesTableView.dataSource = nil
        properties.bind(to: propertiesTableView.rx.items(cellIdentifier: "propertiesCell",cellType: propertiesCell.self)) {index,property,cell in
            cell.properties = self.properties.value
            cell.setUpCell(property: property)
            cell.optionsDropDown.selectionAction = { [weak self] (index, item) in
                self?.propertiesProtocolDelegate?.didSelectOptions(at: index, propertyId:  property.id ?? 0)
            }
            cell.didSelectChildOption = { (childIndex, OptionId,propertyID) in
                self.propertiesProtocolDelegate?.didSelectChildOptions(at: childIndex, optionID: OptionId, propertyId: propertyID)
            }
            cell.otherValue = {otherValue  in
                self.propertiesProtocolDelegate?.didSetOtherValueForProperty(otherValue:otherValue,propertyId: property.id ?? 0)
            }
            }.disposed(by: disposeBag)
        }
}
extension PropertyCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//extension PropertyCell: propertiesProtocol{
//    func didSelectOptions(at index: Int, propertyId: Int) {
//        propertiesTableView.reloadData()
//    }
//}
