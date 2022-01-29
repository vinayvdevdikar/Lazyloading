/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:

*/

import Foundation

protocol ListScreenConfigurator {
    func configure(viewController: ListScreenController)
}

protocol ListScreenInteractor {
    func fetchAllRecipies()
}

protocol ListScreenRouter {
    func navigateToDetailsScreen()
}

protocol ListScreenPresenter {
    func recipeDidFetchedSuccessfully(with recipes: [RecipeUIModel])
    func recipeDidFail(with error: RecipesError)
}

protocol ListViewControllerInterface {
    func recipesDidLoadSuccessfully(with recipes: [RecipeUIModel])
    func recipesDidFail(with error: RecipesError)
}
