//
//  AsyncImageViewTests.swift
//  
//
//  Created by Marko on 8.8.24..
//

import XCTest
@testable import ImageCachingLibrary

class AsyncImageViewUIKitTests: XCTestCase {
    var asyncImageView: AsyncImageViewUIKit!

    override func setUp() {
        super.setUp()
        asyncImageView = AsyncImageViewUIKit()
    }

    override func tearDown() {
        asyncImageView = nil
        super.tearDown()
    }

    func testLoadImageWithValidURL() {
        let expectation = expectation(description: "loading expectation")
        let placeholderImage = UIImage(named: "placeholder")
        asyncImageView.loadImage(url: "https://example.com/image.jpg", key: "uniqueKey", placeholder: "placeholder")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.5)
        XCTAssertEqual(asyncImageView.image, placeholderImage)
    }

    func testLoadImageWithInvalidURL() {
        asyncImageView.loadImage(url: "invalid-url", key: "uniqueKey", placeholder: "placeholder")

        let placeholderImage = UIImage(named: "placeholder")
        XCTAssertEqual(asyncImageView.image, placeholderImage)
    }
}
