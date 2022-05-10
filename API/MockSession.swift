//
//  MockSession.swift
//  LazyLoadingSampleApp
//
//  Created by Vinay Devdikar on 07/05/22.
//

import Foundation
class MockURLSession: URLSession {
    let mockTask: MockTask = MockTask(data: nil, urlResponse: nil, error: nil)

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if let url = request.url, url.absoluteString.contains("ios/recipes_v3.json") {
            mockTask.completionHandler = completionHandler
            guard let path = Bundle.main.path(forResource: "responseContent", ofType: "json") else { return mockTask }
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    completionHandler(jsonData, URLResponse(), nil)
                }
            }catch {
                print(error)
            }
        }
        
        return mockTask
    }
    
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let _error: Error?
    override var error: Error? {
        return _error
    }

    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }

    override func resume() {
        DispatchQueue.main.async { [weak self] in
            self?.completionHandler(self?.data, self?.urlResponse, self?.error)
        }
    }
}
