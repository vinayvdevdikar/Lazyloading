/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:

*/

import Foundation
class ListScreenRouterImpl: ListScreenRouter {
    weak var viewController: ListScreenController?
    
    init(viewController: ListScreenController) {
        self.viewController = viewController
    }
    
    func navigateToDetailsScreen() {
        // currently this functionlity is not available so keeping this method blank
    }
}
