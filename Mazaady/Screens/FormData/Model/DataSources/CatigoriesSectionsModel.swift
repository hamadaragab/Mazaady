//
//  CatigoriesSectionsModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import Foundation
import RxDataSources
enum CatigoriesSectionsModel {
    case MainCatigories(title: String,items: [SectionItem])
//    case SubCatigories(title: String,items: [SectionItem])
    case Properties(title: String,items: [SectionItem])
  
}
enum SectionItem {
    case MainCatigories([Categories])
//    case SubCatigories([Children])
    case Properties([Property])
}
extension CatigoriesSectionsModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .MainCatigories(title: _, items: let items):
            return items.map { $0 }
//        case .SubCatigories(title: _, items: let items):
//            return items.map { $0 }
        case .Properties(title: _, items: let items):
            return items.map { $0 }
        }
    }
    init(original: CatigoriesSectionsModel, items: [Item]) {
        switch original {
        case let .MainCatigories(title: title, items: _):
            self = .MainCatigories(title: title, items: items)
//        case let .SubCatigories(title: title, items: _):
//            self = .SubCatigories(title: title, items: items)
        case let .Properties(title: title, items: _):
            self = .Properties(title: title, items: items)
        }
    }
    
}
extension CatigoriesSectionsModel {
    var title: String {
        switch self {
        case .MainCatigories(title: let title, items: _):
            return title
//        case .SubCatigories(title: let title, items: _):
//            return title
        case .Properties(title: let title, items: _):
            return title
       
        }
    }
}
