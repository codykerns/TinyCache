import XCTest
@testable import TinyCache

final class TinyCacheTests: XCTestCase {
    func testSetCacheValueWithExpirationSavesInCache() {
        TinyCache.clear()

        let key = "key"
        let value = "value"

        XCTAssertNil(TinyCache.value(String.self, key: key))
        TinyCache.cache(key, value: value)
        XCTAssertNotNil(TinyCache.value(String.self, key: key))
    }

    func testSetCacheValueWithExpirationDateSavesInCache() {
        TinyCache.clear()

        let key = "key"
        let value = "value"

        XCTAssertNil(TinyCache.value(String.self, key: key))
        TinyCache.cache(key, value: value, expiration: Date().add(minutes: 71))
        XCTAssertNotNil(TinyCache.value(String.self, key: key))
    }

    func testCachedValueIsNilIfWrongType() {
        let key = "key"
        let value = "value"

        TinyCache.cache(key, value: value)
        XCTAssertNotNil(TinyCache.value(String.self, key: key))
        XCTAssertNil(TinyCache.value(Bool.self, key: key))
    }

    func testClearCacheRemovesAllValues() {
        let key = "key"
        let value = "value"

        TinyCache.cache(key, value: value)
        XCTAssertNotNil(TinyCache.value(String.self, key: key))
        TinyCache.clear()
        XCTAssertNil(TinyCache.value(String.self, key: key))
    }

    func testFetchingValueClearsExpiredValues() {
        TinyCache.clear()

        let key = "key"
        let value = "value"

        XCTAssertNil(TinyCache.value(String.self, key: key))
        TinyCache.cache(key, value: value, expiration: Date().add(minutes: -1))
        XCTAssertNil(TinyCache.value(String.self, key: key))
    }
}
