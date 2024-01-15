//
//  FormRepository.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
protocol FormRepositoryProtocol: AnyObject {
    func getMainCatigories( completion: @escaping (Result<[Categories], ErrorStatus>)->())
    func getPropertiesForSubCatigory(subCatigoryID: Int,completion: @escaping (Result<[Property], ErrorStatus>) -> ())
    func getOptionsChilds(optionId: Int,completion: @escaping (Result<[OptionsChilds], ErrorStatus>) -> ())
}
class FormRepository: FormRepositoryProtocol {
    func getOptionsChilds(optionId: Int, completion: @escaping (Result<[OptionsChilds], ErrorStatus>) -> ()) {
        let url = URLS.OPTIONS + String(optionId)
        NetworkServices.request(url, queryItems: [], responseType: OptionsData.self) { response in
            switch response {
            case .success(let model):
                completion(.success(model.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getMainCatigories( completion: @escaping(Result<[Categories], ErrorStatus>)->()){
        NetworkServices.request(URLS.CATIGORIES, queryItems: [], responseType: MainCatigoriesRespone.self) { response in
            switch response {
            case .success(let model):
                completion(.success(model.data?.categories ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getPropertiesForSubCatigory(subCatigoryID: Int,completion: @escaping (Result<[Property], ErrorStatus>) -> ()) {
        let url = URLS.PROPERTIES + String(subCatigoryID)
        NetworkServices.request(url, queryItems: [], responseType: PropertiesResponse.self) { response in
            switch response {
            case .success(let model):
                completion(.success(model.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
