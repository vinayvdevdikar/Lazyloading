//
//  ListViewInteractor.swift
//  LazyLoadingSampleApp
//
//  Created by Vinay Devdikar on 22/01/22.
//
import XCTest
@testable import LazyLoadingSampleApp
class ListScreenInteractorTest: XCTestCase {
    var mockInteractor: ListScreenInteractorImpl!
    var mockPreseneter: MockPresenter!
    let queue = DispatchQueue.global()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPreseneter = MockPresenter()
        mockInteractor = ListScreenInteractorImpl(presenter: mockPreseneter,
                                                  provider: ServiceProvider(urlsession: MockURLSession()))
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
   
    func test_fetchAllRecipiesWithViewUpdate() {
        mockInteractor.fetchAllRecipies()
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        queue.asyncAfter(deadline: .now() + 3.0) {
            XCTAssertFalse(self.mockPreseneter.recipes.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}


class MockPresenter: ListScreenPresenter {
    var isCalledMethod = false
    var recipes: [RecipeUIModel] = []
    
    func recipeDidFetchedSuccessfully(with recipes: [RecipeUIModel]) {
        isCalledMethod = true
        self.recipes = recipes
    }
    
    func recipeDidFail(with error: RecipesError) {
        isCalledMethod = true
    }
    
    func resetFlag() {
        isCalledMethod = false
        recipes = []
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
