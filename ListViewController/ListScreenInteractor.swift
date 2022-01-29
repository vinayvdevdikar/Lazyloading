/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:

*/

import Foundation
import UIKit
class ListScreenInteractorImpl: ListScreenInteractor {
    let presenter: ListScreenPresenter
    let provider: ServiceProvider
    init(presenter: ListScreenPresenter, provider: ServiceProvider) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func fetchAllRecipies() {
        provider.listAllRecipies(.recipes) { [weak self] result in
            switch result {
            case .sucess(let recipes):
                let uiModel = self?.updateToUIModel(recipes: recipes)
                self?.presenter.recipeDidFetchedSuccessfully(with: uiModel ?? [])
            case .failure(let error):
                self?.presenter.recipeDidFail(with: error)
            }
        }
    }
    
    func updateToUIModel(recipes: Recipes) -> [RecipeUIModel] {
        var uiModel: [RecipeUIModel] = []
        recipes.forEach { result in
            uiModel.append(result.convertTo())
        }
        return uiModel
    }
}
