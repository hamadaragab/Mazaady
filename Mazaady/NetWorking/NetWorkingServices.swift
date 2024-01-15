//
//  NetWorkingServices.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import Alamofire
class NetworkServices {
    typealias CompletionHandler<T: Decodable> = (Result<T, ErrorStatus>) -> Void
    class func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: [String:Any]? = nil,queryItems: [URLQueryItem],
        encoding: ParameterEncoding = URLEncoding.default,
        responseType: T.Type,
        completion: @escaping CompletionHandler<T>
    ) {
        guard let url = URL(string: url), let finalUrl = url.appending(queryItems) else {
            return completion(.failure(ErrorStatus.InvalidURL))
        }
        let  headers:HTTPHeaders =  [ "Content-Type": "application/json","private-key":"3%o8i}_;3D4bF]G5@22r2)Et1&mLJ4?$@+16"]
        let request = AF.request(finalUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
        let requestReference = request.validate().responseDecodable(of: responseType) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(.JsonParsingFailed))
            }
        }
    }
}
