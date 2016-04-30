import XCTest
import Foundation

@testable import Awaitable

class AwaitableTests: XCTestCase {
  static var allTests: [(String, AwaitableTests -> () throws -> Void)] {
    return [
      ("testReduceManyBlock", testReduceManyBlock),
      ("testAwaitDelayBlock", testAwaitDelayBlock),
    ]
  }

  func testReduceManyBlock() {
    let t = async { () -> [() -> Int] in
      var a: [() -> Int] = []
      for i in 1...100 {
        a.append({ () -> Int in
          sleep(2)
          return i
        })
      }
      return a
    }
    let v = t.await().reduce(0) { $0 + $1 }

    XCTAssertEqual(v, 5050)
  }

  func testAwaitDelayBlock() {
    let num = async { () -> Int in
      sleep(2)
      return 10
    }
    let v = num.await()

    XCTAssertEqual(v, 10)
  }
}
