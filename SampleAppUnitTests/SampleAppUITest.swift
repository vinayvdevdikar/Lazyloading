//
//  SampleAppUITest.swift
//  LazyLoadingSampleAppTests
//
//  Created by Vinay Devdikar on 10/05/22.
//

import XCTest
import iOSSnapshotTestCase
@testable import LazyLoadingSampleApp

class SampleAppUITest: FBSnapshotTestCase {
    var mockInteractor: ListScreenInteractorImpl!
    var mockPreseneter: MockPresenter!
    let queue = DispatchQueue.main
    var sut: ListScreenController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(identifier: "kViewController")
        
        mockPreseneter = MockPresenter()
        mockInteractor = ListScreenInteractorImpl(presenter: mockPreseneter,
                                                  provider: ServiceProvider(urlsession: MockURLSession()))
        sut.viewDidLoad()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetchAllRecipiesWithViewUpdate() {
        recordMode = false
        mockInteractor.fetchAllRecipies()
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        queue.asyncAfter(deadline: .now() + 10.0) {
            self.FBSnapshotVerifyView(self.sut.view)
            self.FBSnapshotVerifyLayer(self.sut.view.layer)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
