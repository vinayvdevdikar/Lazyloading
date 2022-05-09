//
//  ImageCacheTest.swift
//  LazyLoadingSampleAppTests
//
//  Created by Vinay Devdikar on 27/01/22.
//

import XCTest
@testable import LazyLoadingSampleApp

class ImageCacheTest: XCTestCase {

    func test_loadImaeHappyFlow() {
        guard let url = URL(string: "https://cooksmarts.imgix.net/meal_photos/1810/20211004_Moroccan_Spiced_Skirt_Steak-NM-2.jpg") else { return }
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        ImageCache.publicCache.load(url: url as NSURL, completion: { image in
            XCTAssertNotNil(image)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func test_loadImaeErrorCase() {
        guard let url = URL(string: "http://3.bp.blogspot.com/-MJJ_2T78qj4/t6Wgw9lfot0/s1600/IMG_5475-a.JPG") else { return }
        let expectation: XCTestExpectation = XCTestExpectation(description: "")
        ImageCache.publicCache.load(url: url as NSURL, completion: { image in
            XCTAssertNil(image)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        
    }

}
