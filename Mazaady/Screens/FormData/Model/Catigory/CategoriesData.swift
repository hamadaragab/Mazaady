//
//  CategoriesData.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
struct CategoriesData : Codable {
    let categories : [Categories]?
    let statistics : Statistics?
    let ads_banners : [Ads_banners]?
    let ios_version : String?
    let ios_latest_version : String?
    let google_version : String?
    let huawei_version : String?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case statistics = "statistics"
        case ads_banners = "ads_banners"
        case ios_version = "ios_version"
        case ios_latest_version = "ios_latest_version"
        case google_version = "google_version"
        case huawei_version = "huawei_version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        statistics = try values.decodeIfPresent(Statistics.self, forKey: .statistics)
        ads_banners = try values.decodeIfPresent([Ads_banners].self, forKey: .ads_banners)
        ios_version = try values.decodeIfPresent(String.self, forKey: .ios_version)
        ios_latest_version = try values.decodeIfPresent(String.self, forKey: .ios_latest_version)
        google_version = try values.decodeIfPresent(String.self, forKey: .google_version)
        huawei_version = try values.decodeIfPresent(String.self, forKey: .huawei_version)
    }

}
