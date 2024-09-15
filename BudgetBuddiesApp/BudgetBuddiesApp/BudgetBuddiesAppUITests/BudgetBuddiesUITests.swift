import XCTest

@testable import BudgetBuddiesApp

class BudgetBuddiesAppUITests: XCTestCase {

  @MainActor
  override func setUp() {
    let app = XCUIApplication()
    continueAfterFailure = false
    setupSnapshot(app)
    app.launch()
  }

  @MainActor
  func testTakingSnapShot() {
    snapshot("01_MainScreen")
  }
}
