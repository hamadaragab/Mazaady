//
//  Options.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
struct Options : Codable {
  
    let id : Int?
    let name : String?
    let slug : String?
    let parent : Int?
    let child : Bool?
    var isSelected = false
    var childsOptions : [Options]?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case slug = "slug"
        case parent = "parent"
        case child = "child"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        parent = try values.decodeIfPresent(Int.self, forKey: .parent)
        child = try values.decodeIfPresent(Bool.self, forKey: .child)
    }
    init(id: Int? = nil, name: String? = nil, slug: String? = nil, parent: Int? = nil, child: Bool? = nil, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.slug = slug
        self.parent = parent
        self.child = child
        self.isSelected = isSelected
    }
    

}
