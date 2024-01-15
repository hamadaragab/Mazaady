//
//  FormViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
struct DisplayedData{
    var name:String
    var value: String
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
}
protocol FormViewModelProtocol: AnyObject {
    var input: FormViewModel.Input {get}
    var output: FormViewModel.Output {get}
    func viewDidLoad()
    func getSubCatigriesForSelectedMainCatigory(selectedCatigoryIndex: Int)
    func getPropertiesForSelectedSubCatigoryAtIndex(Index: Int)
    func didSelectChildOptions(at index: Int, optionID: Int, propertyId: Int)
    func getChildsOptions(at index: Int, propertyId: Int)
    func didSetOtherValueForProperty(otherValue: String, propertyId: Int)
}
class FormViewModel:FormViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    private var repository: FormRepositoryProtocol?
    private var catigories: [Categories] = []
    var subCatigories: [Children] = []
    private var properties: [Property] = []
    var sections: [CatigoriesSectionsModel] = []
    private var displayedData:[DisplayedData] = []
    init(repository: FormRepositoryProtocol) {
        self.repository = repository
        getCatigories()
    }
    func viewDidLoad(){
        input.showDataTapped.subscribe(onNext: { [weak self] _ in
            guard let self = self else {return}
            self.displayedData = []
            for property in self.properties {
                var value = ""
                let name = property.name ?? ""
                if let selectedChild = property.options?.filter({ $0.isSelected }).first?.childsOptions?.filter({ $0.isSelected }).first {
                    value = selectedChild.name ?? ""
                }else if let selectedOption = property.options?.filter({$0.isSelected}).first,selectedOption.name != "Other"{
                    value = selectedOption.name ?? ""
                }
                else if let otherVlaue = property.other_value {
                    value = otherVlaue
                }
                self.displayedData.append(DisplayedData(name: name, value: value))
            }
            self.output.displayedData.onNext(self.displayedData)
        }).disposed(by: disposeBag)
    }
    func getSubCatigriesForSelectedMainCatigory(selectedCatigoryIndex: Int) {
        let subCatigories = catigories[selectedCatigoryIndex].children ?? []
        self.subCatigories = subCatigories
        
        self.output.subCatigories.accept(subCatigories)
        self.output._section_Models.accept(sections)
    }
    private func getCatigories() {
        output.showLoading.onNext(true)
        repository?.getMainCatigories { respone in
            self.output.showLoading.onNext(false)
            switch respone{
            case .success(let catigories):
                self.catigories = catigories
                self.sections.append(.MainCatigories(title: "MainCatigories", items: [.MainCatigories(catigories)]))
                self.output._section_Models.accept(self.sections)
            case .failure(let error):
                self.output.message.onNext(error.rawValue)
            }
        }
    }
    func didSetOtherValueForProperty(otherValue: String, propertyId: Int) {
        guard let firstIndex = properties.firstIndex(where: {$0.id == propertyId}) else {return}
        properties[firstIndex].other_value = otherValue
    }
    func getPropertiesForSelectedSubCatigoryAtIndex(Index: Int) {
        guard let subCatigoryID = self.subCatigories[Index].id else {return}
        output.showLoading.onNext(true)
        repository?.getPropertiesForSubCatigory(subCatigoryID: subCatigoryID, completion: { respone in
            self.output.showLoading.onNext(false)
            switch respone{
            case .success(let properties):
                self.didGetProperties(properties: properties)
            case .failure(let error):
                self.output.message.onNext(error.rawValue)
            }
        })
    }
    private func didGetProperties(properties: [Property]) {
        if let index = sections.firstIndex(where: {$0.title == "Properties"}) {
            self.properties = []
            sections.remove(at: index)
        }
        for property in properties {
            var propertyData = property
            propertyData.options?.append(Options(id: 888, name: "Other", slug: "Other", parent: nil, child: nil, isSelected: false))
            self.properties.append(propertyData)
        }
        self.output.subCatigoriesProperties.onNext(self.properties)
        
        sections.append(.Properties(title: "Properties", items: [.Properties(self.properties)]))
        self.output._section_Models.accept(self.sections)
    }
    func didSelectOptions(at index: Int, propertyId: Int) {
        if let firstIndex = properties.firstIndex(where: {$0.id == propertyId}) {
            var property =  properties[firstIndex].options ?? []
            for i in 0..<property.count {
                if i == index {
                    property[i].isSelected = true
                }else {
                    property[i].isSelected = false
                }
            }
            properties[firstIndex].options = property
            if let index = self.sections.firstIndex(where: {$0.title == "Properties"}) {
                self.sections.remove(at: index)
            }
            self.sections.append(.Properties(title: "Properties", items: [.Properties(self.properties)]))
            self.output._section_Models.accept(self.sections)
        }
    }
    func getChildsOptions(at index: Int, propertyId: Int) {
        if let firstIndex = properties.firstIndex(where: {$0.id == propertyId}),let optionId = properties[firstIndex].options?[index].id {
            output.showLoading.onNext(true)
            repository?.getOptionsChilds(optionId: optionId, completion: { response in
                self.output.showLoading.onNext(false)
                switch response {
                case .success(let option):
                    self.properties[firstIndex].options?[index].childsOptions = option.first?.options ?? []
                    self.didSelectOptions(at: index, propertyId: propertyId)
                case.failure(let error):
                    print(error.rawValue)
                }
            })
        }
    }
    func didSelectChildOptions(at index: Int, optionID: Int, propertyId: Int) {
        if let firstIndex = properties.firstIndex(where: {$0.id == propertyId}),let selectedOptionFirstIndex = properties[firstIndex].options?.firstIndex(where: {$0.id == optionID}), var selectedOption =  properties[firstIndex].options?[selectedOptionFirstIndex]{
            for i in 0..<(selectedOption.childsOptions ?? []).count{
                if i == index {
                    selectedOption.childsOptions?[i].isSelected = true
                }else {
                    selectedOption.childsOptions?[i].isSelected = false
                }
            }
            properties[firstIndex].options?[selectedOptionFirstIndex] = selectedOption
            if let index = self.sections.firstIndex(where: {$0.title == "Properties"}) {
                self.sections.remove(at: index)
            }
            self.sections.append(.Properties(title: "Properties", items: [.Properties(self.properties)]))
            self.output._section_Models.accept(self.sections)
        }
    }
}

extension FormViewModel: BaseViewModel {
    struct Input {
        let showDataTapped = PublishSubject<Void>()
    }
    class Output {
        let showLoading = PublishSubject<Bool>()
        let mainCatigories = PublishSubject<[Categories]>()
        let subCatigories = BehaviorRelay<[Children]>(value: [])
        let subCatigoriesProperties = PublishSubject<[Property]>()
        let message = PublishSubject<String>()
        var _section_Models: BehaviorRelay<[CatigoriesSectionsModel]> = BehaviorRelay(value: [])
        var section_Models: SharedSequence<DriverSharingStrategy, [CatigoriesSectionsModel]> {
            return _section_Models.asDriver(onErrorJustReturn: [])}
        let displayedData = PublishSubject<[DisplayedData]>()
    }
    
}
