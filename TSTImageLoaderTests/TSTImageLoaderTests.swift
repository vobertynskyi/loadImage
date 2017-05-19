//
//  TSTImageLoaderTests.swift
//  TSTImageLoaderTests
//
//  Created by Vitalii Obertynskyi on 5/19/17.
//  Copyright © 2017 vobertynskyi. All rights reserved.
//

import XCTest
@testable import TSTImageLoader

class MainTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testExample() {
        
        let expect = expectation(description: "...")
        
        let imageDownloader = ImageDownloader()
        
        let model = ImageModel(imageUrl: "http://loremflickr.com/320/240/moon?randome=1")
        
        imageDownloader.downloadImage(with: model) {
            
            expect.fulfill()
            let image = model.loadFileFromCache()
            XCTAssertNotNil(image, "Download image was failed")
            XCTAssertEqual(image?.size, CGSize(width: 320, height: 240))
        }
        
        waitForExpectations(timeout: 30) { error in
            print(error?.localizedDescription ?? "")
        }
    }
}
