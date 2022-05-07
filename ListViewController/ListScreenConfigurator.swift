/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
Configuration for list item.
*/

import Foundation
class ListScreenConfiguratorImpl: ListScreenConfigurator {
    func configure(viewController: ListScreenController){
        let presenter = ListScreenPresenterImpl(viewController: viewController)
        let provider = ServiceProvider(urlsession: MockURLSession())
        viewController.interactor = ListScreenInteractorImpl(presenter: presenter,
                                                             provider: provider)
        viewController.router = ListScreenRouterImpl(viewController: viewController)
    }
}
