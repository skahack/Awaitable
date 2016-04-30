#if os(Linux)

import XCTest

@testable import AwaitableTestSuite

XCTMain([
  testCase(AwaitableTests.allTests),
])

#endif
