//
//  ListScreenPresnter.swift
//  LazyLoadingSampleApp
//
//  Created by Vinay Devdikar on 22/01/22.
//
import XCTest
@testable import LazyLoadingSampleApp
class ListScreenPresenterTest: XCTestCase {
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
   
    func test_fetchAllRecipies() {
        mockInteractor.fetchAllRecipies()
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        queue.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertTrue(self.mockPreseneter.isCalledMethod)
            self.mockPreseneter.resetFlag()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    

}
