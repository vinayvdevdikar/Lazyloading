/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
A Model Recipe for showing respone on UI
*/

import Foundation
struct RecipeUIModel {
    let name: String
    let headline: String
    let imageUrl: String
    let prepmin: Int
    
}

extension Recipe {
    
    func convertTo() -> RecipeUIModel {
        guard let name = self.name,
              let headline = self.headline,
              let image = self.imageUrl,
              let prepmin = self.prepmin else { return RecipeUIModel(name: "",
                                                                     headline: "",
                                                                     imageUrl: "",
                                                                     prepmin: 0)}
        return RecipeUIModel(name: name,
                             headline: headline,
                             imageUrl: image,
                             prepmin: prepmin)
    }
}
