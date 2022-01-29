/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
API Endpoint manager.
*/

import Foundation
enum APIEndPoint {
    static let host: String = "https://hf-mobile-app.s3-eu-west-1.amazonaws.com"
    case recipes
    
    var path: String {
        switch self {
        case .recipes:
            return "/ios/recipes_v3.json"
        }
    }
    
    func createRequest() -> URLRequest? {
        let stringUrl = "\(APIEndPoint.host)\(path)"
        guard let api = URL(string: stringUrl) else { return nil  }
        return URLRequest(url: api)
    }
}
