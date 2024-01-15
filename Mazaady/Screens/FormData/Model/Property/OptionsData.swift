//
//  OptionsData.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation

struct OptionsData : Codable {
    let code : Int?
    let msg : String?
    let data : [OptionsChilds]?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([OptionsChilds].self, forKey: .data)
    }

}
