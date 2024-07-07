//
//  MVVMRxSwiftUITests.swift
//  MVVMRxSwiftUITests
//
//  Created by Михаил Бойко on 19.07.2022.
//

import XCTest

class MVVMRxSwiftUITests: XCTestCase {
    private let app = XCUIApplication()
    var cryptocurrenciesPage: CryptocurrenciesPage!

    private let screenName = "GalleryController"

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app.launchArguments.append("Testing")

        app.launch()
        
        cryptocurrenciesPage = CryptocurrenciesPage(app: app)
    }

    func testNavigationBarTitle() throws {
        step(named: "Проверяем, что открылся именно \(screenName)") {
            XCTAssert(app.descendants(matching: .any)[screenName].exists)
        }

        step(named: "Проверяем title") {
            XCTAssert(app.navigationBars["Crypto List"].exists)
        }

        let table = app.tables["GalleryController_tableView"]
        step(named: "Проверяем наличие tableView") {
            XCTAssert(table.exists)
        }
    }

    private func step(named name: String, activity: () -> Void) {
        XCTContext.runActivity(named: "\(screenName): \(name)") { _ in
            activity()
        }
    }
    
    func testScrollToCell() {
        // Scroll to a particular cell, e.g., 10th cell
        cryptocurrenciesPage.scrollToCell(at: 10)
        
        // Verify that the cell is visible
        let cell = cryptocurrenciesPage.tableView.cells.element(boundBy: 10)
        XCTAssertTrue(cell.isHittable, "Cell at index 10 should be visible and hittable")
    }

}
