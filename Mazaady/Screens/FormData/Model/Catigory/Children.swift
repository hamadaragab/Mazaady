//
//  Children.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
struct Children : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let image : String?
    let slug : String?
    let children : String?
    let circle_icon : String?
    let disable_shipping : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case image = "image"
        case slug = "slug"
        case children = "children"
        case circle_icon = "circle_icon"
        case disable_shipping = "disable_shipping"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        children = try values.decodeIfPresent(String.self, forKey: .children)
        circle_icon = try values.decodeIfPresent(String.self, forKey: .circle_icon)
        disable_shipping = try values.decodeIfPresent(Int.self, forKey: .disable_shipping)
    }

}
