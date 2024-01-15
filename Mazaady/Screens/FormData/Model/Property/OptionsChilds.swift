//
//  OptionsData.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
struct OptionsChilds : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let slug : String?
    let parent : Int?
    let list : Bool?
    let type : String?
    let value : String?
    let other_value : String?
    let options : [Options]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case slug = "slug"
        case parent = "parent"
        case list = "list"
        case type = "type"
        case value = "value"
        case other_value = "other_value"
        case options = "options"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        parent = try values.decodeIfPresent(Int.self, forKey: .parent)
        list = try values.decodeIfPresent(Bool.self, forKey: .list)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        other_value = try values.decodeIfPresent(String.self, forKey: .other_value)
        options = try values.decodeIfPresent([Options].self, forKey: .options)
    }

}
