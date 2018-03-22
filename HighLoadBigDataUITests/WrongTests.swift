import XCTest

class WrongTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        
        app.cells["Cell"].buttons.element(boundBy: 1)
        
        app.buttons.element(
            matching: NSPredicate(
                format: "accessibilityTitle BEGINSWITH[cd] %@", "Префикс"
            )
        )
        
        continueAfterFailure = false
    }
    
    func test_showingThat_scrollGivesFalsePositive() {
        app.tables.buttons["Скролл отключен"].tap()
        
        // Реально кот невидим
        XCTAssert(XCUIApplication().cells["LastCat"].exists)
        
        // Реально кота нельзя тапнуть
        XCUIApplication().cells["LastCat"].tap()
    }
    
    func test_showingThat_visibilityCheckCanLeadToFalseNegative() {
        app.tables.buttons["Видимая вьюшка"].tap()
        
        XCTAssert(app.images.element(boundBy: 0).exists)
        XCTAssert(app.images.element(boundBy: 0).isWithin(app))
        XCTAssert(app.images.element(boundBy: 0).isHittable)
    }
    
    func test_showingThat_overlappingLeadsToFalseNegative() {
        app.tables.buttons["Перекрытие вьюшкой"].tap()
        
        let lastCat = app.images["LastCat"]
        
        XCTAssert(lastCat.exists)
        
        let scrollLimit = 10
        for _ in 0..<scrollLimit where !lastCat.isWithin(app) {
            let startPoint = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let endPoint = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
            
            startPoint.press(forDuration: 0, thenDragTo: endPoint)
        }
        
        XCTAssert(lastCat.isWithin(app))
    }
}

extension XCUIElement {
    func isWithin(_ other: XCUIElement) -> Bool {
        return frame.width > 0
            && frame.height > 0
            && frame.intersection(other.frame) == frame
    }
}
