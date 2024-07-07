//
//  CryptocurrenciesPage.swift
//  MVVMRxSwiftUITests
//
//  Created by Mikhail Boiko on 4/7/24.
//

import XCTest

class CryptocurrenciesPage {
    private let app: XCUIApplication

    var tableView: XCUIElement { return app.tables["GalleryController_tableView"] }

    init(app: XCUIApplication) {
        self.app = app
    }

    // Actions
    func pullToRefresh() {
        let firstCell = tableView.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }

    func tapOnCell(at index: Int) {
        let cell = tableView.cells.element(boundBy: index)
        XCTAssertTrue(cell.exists, "Cell at index \(index) does not exist")
        cell.tap()
    }

    func scrollToCell(at index: Int) {
        let cell = tableView.cells.element(boundBy: index)
        tableView.scrollToElement(element: cell)
    }
}

private extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}


