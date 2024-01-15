//
//  Statistics.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
struct Statistics : Codable {
    let auctions : Int?
    let users : Int?
    let products : Int?

    enum CodingKeys: String, CodingKey {

        case auctions = "auctions"
        case users = "users"
        case products = "products"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        auctions = try values.decodeIfPresent(Int.self, forKey: .auctions)
        users = try values.decodeIfPresent(Int.self, forKey: .users)
        products = try values.decodeIfPresent(Int.self, forKey: .products)
    }

}
