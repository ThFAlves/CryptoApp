import XCTest

class CryptoAppUITests: XCTestCase {
    func testOpenDetail() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Binance").element.tap()
    }
    
    func testOpenWebView() {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["BINANCE"]/*[[".cells.staticTexts[\"BINANCE\"]",".staticTexts[\"BINANCE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Abrir Website"]/*[[".buttons[\"Abrir Website\"].staticTexts[\"Abrir Website\"]",".staticTexts[\"Abrir Website\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
