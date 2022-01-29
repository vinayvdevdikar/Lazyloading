/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
Configuration for list item.
*/

import Foundation
class ListScreenConfiguratorImpl: ListScreenConfigurator {
    func configure(viewController: ListScreenController){
        let presenter = ListScreenPresenterImpl(viewController: viewController)
        viewController.interactor = ListScreenInteractorImpl(presenter: presenter,
                                                             provider: ServiceProvider())
        viewController.router = ListScreenRouterImpl(viewController: viewController)
    }
}
