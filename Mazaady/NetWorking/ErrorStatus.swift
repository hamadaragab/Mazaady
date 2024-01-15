//
//  ErrorStatus.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
enum ErrorStatus: String, Error {
    case InvalidURL
    case InvalidResponse
    case RequestFailed
    case JsonParsingFailed
    case NoInternetConnection = "No Internet Conenction Found"
    case TimeOut = "Request Time Out "
}
