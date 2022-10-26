import XCTest

final class ProductListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testDataLoaded() {
        let app = XCUIApplication()
        app.launchArguments = ["–uitesting"]
        app.launch()
        let favButton = app.buttons["Favourites"]
        XCTAssertTrue(favButton.waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        XCTAssertTrue(app.staticTexts["Diamond Label Shiraz"].exists)
        favButton.tap()
        XCTAssertTrue(!app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(!app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        XCTAssertTrue(!app.staticTexts["Diamond Label Shiraz"].exists)
    }
    
    func testFavouriteButton () {
        let app = XCUIApplication()
        app.launchArguments = ["–uitesting"]
        app.launch()
        let favButton = app.buttons["Favourites"]
        XCTAssertTrue(favButton.waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        XCTAssertTrue(app.staticTexts["Diamond Label Shiraz"].exists)
        let firstLoveButton = app.buttons["Love"].firstMatch
        firstLoveButton.tap()
        favButton.tap()
        XCTAssertTrue(app.staticTexts["Diamond Label Shiraz"].exists)
        XCTAssertTrue(!app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(!app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        app.buttons["Love"].firstMatch.tap()
        XCTAssertTrue(!app.staticTexts["Diamond Label Shiraz"].exists)
    }
    
    func testProuctDetails () {
        let app = XCUIApplication()
        app.launchArguments = ["–uitesting"]
        app.launch()
        let favButton = app.buttons["Favourites"]
        XCTAssertTrue(favButton.waitForExistence(timeout: 10))
        XCTAssertTrue(app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        XCTAssertTrue(app.staticTexts["Diamond Label Shiraz"].exists)
        app.buttons["Love"].firstMatch.tap()
        favButton.tap()
        XCTAssertTrue(app.staticTexts["Diamond Label Shiraz"].exists)
        XCTAssertTrue(!app.staticTexts["Shiraz"].exists)
        XCTAssertTrue(!app.staticTexts["Bin 389 Cabernet Shiraz 2019"].exists)
        app.staticTexts["Diamond Label Shiraz"].tap()
        XCTAssertTrue(app.staticTexts["4.00"].exists)
        app.buttons["Love"].firstMatch.tap()
        app.buttons["Back"].firstMatch.tap()
        sleep(3)
        XCTAssertTrue(!app.staticTexts["Diamond Label Shiraz"].exists)
    }
}
