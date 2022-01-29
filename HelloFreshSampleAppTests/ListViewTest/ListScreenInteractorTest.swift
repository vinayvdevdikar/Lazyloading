//
//  ListViewInteractor.swift
//  HelloFreshSampleApp
//
//  Created by Vinay Devdikar on 22/01/22.
//
import XCTest
@testable import HelloFreshSampleApp
class ListScreenInteractorTest: XCTestCase {
    var mockInteractor: ListScreenInteractorImpl!
    var mockPreseneter: MockPresenter!
    var mockViewController: ListScreenController!
    let queue = DispatchQueue.global()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = ListScreenController()
        mockPreseneter = MockPresenter(viewController: mockViewController)
        mockInteractor = ListScreenInteractorImpl(presenter: mockPreseneter,
                                                  provider: ServiceProvider(urlsession: MockURLSession.shared))
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
   
    func test_fetchAllRecipiesWithViewUpdate() {
        mockInteractor.fetchAllRecipies()
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        queue.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertFalse(self.mockViewController.listOfRecipes.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}


class MockURLSession: URLSession {
    let mockTask: MockTask = MockTask(data: nil, urlResponse: nil, error: nil)

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if let url = request.url, url.absoluteString.contains("ios/recipes_v3.json") {
            guard let path = Bundle.main.path(forResource: "responseContent", ofType: "json") else { return mockTask }
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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


class MockPresenter: ListScreenPresenterImpl {
    var isCalledMethod = false
    
    override func recipeDidFetchedSuccessfully(with recipes: [RecipeUIModel]) {
        super.recipeDidFetchedSuccessfully(with: recipes)
        isCalledMethod = true
    }
    
    override func recipeDidFail(with error: RecipesError) {
        super.recipeDidFail(with: error)
        isCalledMethod = true
    }
    
    func resetFlag() {
        isCalledMethod = false
    }
    
}

class MockRouter: ListScreenRouterImpl {
    var isMethodCalled = false
    
    override func navigateToDetailsScreen() {
        super.navigateToDetailsScreen()
        isMethodCalled = true
    }
    
    func resetFlag() {
        isMethodCalled = false
    }
}
