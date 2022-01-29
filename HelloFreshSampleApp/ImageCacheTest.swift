//
//  ImageCacheTest.swift
//  HelloFreshSampleAppTests
//
//  Created by Vinay Devdikar on 27/01/22.
//

import XCTest
@testable import HelloFreshSampleApp

class ImageCacheTest: XCTestCase {

    func test_loadImaeHappyFlow() {
        guard let url = URL(string: "https://img.hellofresh.com/f_auto,q_auto/hellofresh_s3/image/533143aaff604d567f8b4571.jpg") else { return }
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        ImageCache.publicCache.load(url: url as NSURL, completion: { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func test_loadImaeErrorCase() {
        guard let url = URL(string: "https://img.hellofresh.com/hellofresh_s3/533143aaff604d567f8b4571.jpg") else { return }
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        ImageCache.publicCache.load(url: url as NSURL, completion: { image in
            XCTAssertNil(image)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        
    }

}
