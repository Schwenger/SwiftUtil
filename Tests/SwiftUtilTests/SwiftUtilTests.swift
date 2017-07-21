import XCTest
@testable import SwiftUtil

class SwiftUtilTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwiftUtil().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
