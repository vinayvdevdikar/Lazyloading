/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:

*/

import Foundation
class ListScreenPresenterImpl: ListScreenPresenter {
    weak var viewController: ListScreenController?
    
    init(viewController: ListScreenController) {
        self.viewController = viewController
    }
    
    func recipeDidFetchedSuccessfully(with recipes: [RecipeUIModel]) {
        self.viewController?.recipesDidLoadSuccessfully(with: recipes)
    }
    
    func recipeDidFail(with error: RecipesError) {
        self.viewController?.recipesDidFail(with: error)
    }
}
