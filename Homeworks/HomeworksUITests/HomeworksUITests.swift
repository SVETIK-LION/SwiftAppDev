import XCTest

final class HomeworksUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTabClick(){
        
        let app = XCUIApplication()
        app.webViews.webViews.webViews.buttons["Продолжить как Svetlana +7 ··· ··· ·· 65"].tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Groups"].tap()
        tabBar.buttons["Photos"].tap()
        tabBar.buttons["My profile"].tap()
    }
}
