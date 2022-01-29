/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
A service intergration class which use to call api.
*/

import Foundation
final class ServiceProvider: RecipiesAPIStrategy {
    private let session: URLSession
    
    init(urlsession: URLSession =  URLSession.shared) {
        self.session = urlsession
    }

    /// fetch all recipies from api with type.
    func listAllRecipies(_ enpoint: APIEndPoint, completion: @escaping (APIResult<Recipes, RecipesError>) -> Void) {
        guard let request = enpoint.createRequest() else { return completion(.failure(.badRequest))  }
        let task = session.dataTask(with: request) { data, respone, error in
            do {
                guard let jsonData = data else { return }
                let responseModel = try JSONDecoder().decode(Recipes.self, from: jsonData)
                completion(.sucess(responseModel))
            }catch {
                completion(.failure(.generic))
            }
        }
        task.resume()
    }
}
