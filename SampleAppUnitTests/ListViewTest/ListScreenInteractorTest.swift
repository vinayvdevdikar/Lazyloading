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
