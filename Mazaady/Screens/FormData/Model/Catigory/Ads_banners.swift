//
//  Ads_banners.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
struct Ads_banners : Codable {
    let img : String?
    let media_type : String?
    let duration : Int?

    enum CodingKeys: String, CodingKey {

        case img = "img"
        case media_type = "media_type"
        case duration = "duration"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
    }

}
