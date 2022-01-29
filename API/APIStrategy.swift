/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
API Strategy protocol
*/

import Foundation
protocol RecipiesAPIStrategy {
    func listAllRecipies(_ enpoint: APIEndPoint, completion: @escaping(APIResult<Recipes,RecipesError>) -> Void)
}
