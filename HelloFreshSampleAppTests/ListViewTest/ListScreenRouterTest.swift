//
//  ListViewRouter.swift
//  HelloFreshSampleApp
//
//  Created by Vinay Devdikar on 22/01/22.
//
import XCTest
@testable import HelloFreshSampleApp
class ListScreenRouterTest: XCTestCase {
    var mockRouter: MockRouter!
    var mockViewController: ListScreenController!
    let queue = DispatchQueue.global()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = ListScreenController()
        mockRouter = MockRouter(viewController: mockViewController)
    }
    
    func test_navigateToDetailsScreen() {
        mockRouter.navigateToDetailsScreen()
        XCTAssertTrue(mockRouter.isMethodCalled)
    }
}
