//
//  CacheDirectoryTests.swift
//  
//
//  Created by Marko on 7.8.24..
//

import XCTest
@testable import ImageCachingLibrary

final class CacheDirectoryTests: XCTestCase {
    
    var sut: CacheDisk<Int>!
    
    override func setUpWithError() throws {
        sut = CacheDisk()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCacheWriteAndGet_KeyAndValuePair_ValueEqualForTheSameKey() {
        let key: String = "1"
        let value: Int = 1
        let save = sut.save(value, forKey: "1")
        XCTAssertTrue(save, "Didn't save the text")
        
        let fetchedValue = sut.value(forKey: key)?.value
        XCTAssertEqual(fetchedValue, value, "Same value")
    }
    
    func testCacheWriteAndGet_KeyAndValuePair_ValueEqualNotEqualForTheSameKey() {
        let key: String = "1"
        let value: Int = 1
        let save = sut.save(value, forKey: key)
        XCTAssertTrue(save, "Didn't save the text")
        
        let getKey: String = "2"
        let fetchedValue = sut.value(forKey: getKey)?.value
        XCTAssertNotEqual(fetchedValue, value, "Same value")
    }
    
    
    func testCacheWriteAndGetData_KeyAndValuePair_ValueEqualNotEqualForTheSameKey() {
        let sutImage = CacheDisk<Data>()
        
        let key: String = "1"
        let value: Data = "Hello".data(using: .utf8)!
        let save = sutImage.save(value, forKey: key)
        XCTAssertTrue(save, "Didn't save the text")
        
        let getKey: String = "2"
        let fetchedValue = sutImage.value(forKey: getKey)?.value
        XCTAssertNotEqual(fetchedValue, value, "Same value")
    }
    
    func testCacheWriteAndGetData_KeyAndValuePair_ValueEqualForTheSameKey() {
        let sutImage = CacheDisk<Data>()
        let key: String = "1"
        let value: Data = "Hello".data(using: .utf8)!
        let save = sutImage.save(value, forKey: "1")
        XCTAssertTrue(save, "Didn't save the text")
        
        let fetchedValue = sutImage.value(forKey: key)?.value
        XCTAssertEqual(fetchedValue, value, "Same value")
    }
    
    func testCacheWriteAndGetDataCacheDuration_KeyAndValuePair_ValueNotEqualForTheSameKey() {
        let sutImage = CacheDisk<Data>(entryLifetime: 0)
        let key: String = "1"
        let value: Data = "Hello".data(using: .utf8)!
        let save = sutImage.save(value, forKey: "1")
        XCTAssertTrue(save, "Didn't save the text")
        
        let fetchedValue = sutImage.value(forKey: key)?.value
        XCTAssertNil(fetchedValue, "Same value")
    }
    
    func testCacheWriteAndDeleteAll_KeyAndValuePair_ValueEqualForTheSameKey() {
        let sutImage = CacheDisk<Data>(entryLifetime: 0)
        let key: String = "1"
        let value: Data = "Hello".data(using: .utf8)!
        let save = sutImage.save(value, forKey: "1")
        XCTAssertTrue(save, "Didn't save the text")
        
        let _ = sutImage.deleteAll()
        
        let fetchedValue = sutImage.value(forKey: key)?.value
        
        XCTAssertNotEqual(fetchedValue, value, "Same value")
    }
}
