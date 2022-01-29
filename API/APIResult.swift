/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
API Result handler.
*/

import Foundation

enum APIResult<Value, Error> {
    case sucess(Value)
    case failure(Error)
}

enum RecipesError: Error {
    case generic
    case badRequest
    case parsingError
    case customError(code: Int, message: String)
}


