import XCTest

class MyNewTest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        
        continueAfterFailure = false
    }
    
    func test() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Скролл отключен"]/*[[".cells.buttons[\"Скролл отключен\"]",".buttons[\"Скролл отключен\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.containing(.image, identifier:"cat_4").element.tap()
        
    }
}
