import XCTest

@testable import BudgetBuddies

class BudgetBuddiesUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launch()
  }

  override func tearDown() {
    app.terminate()
  }

}
