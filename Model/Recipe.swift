/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
A Model Recipe for decoding respone
*/

import Foundation
typealias Recipes = [Recipe]
struct Recipe: Decodable {
    let recipesID: String?
    let name: String?
    let headline: String?
    let imageUrl: String?
    let prepmin: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case headline
        case image
        case preparation_minutes
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipesID = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        headline = try container.decodeIfPresent(String.self, forKey: .headline)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .image)
        prepmin = try container.decodeIfPresent(Int.self, forKey: .preparation_minutes)
    }
}
