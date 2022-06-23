//
//  FirstScreenUITests.swift
//  findRecipeUITests
//
//  Created by Administrator on 24/02/22.
//

import XCTest

class FirstScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchByIngredientsButton() throws {
        let app = XCUIApplication()
        app.launch()
        app.alerts["Unable to fetch reipes"].scrollViews.otherElements.buttons["Ok"].tap()
        app.buttons["search by ingredients"].tap()
        let addIngredientButtonOnNavigationBar = app.navigationBars["findRecipe.AddIngredientsTableView"].buttons["Add"]
        XCTAssertTrue(addIngredientButtonOnNavigationBar.exists)
                
    }

    func testClickingRandomRecipe() throws {
//
        let tablesQuery = XCUIApplication().tables
    
//    tablesQuery.cellForRow(at: 0)
//        tablesQuery.cells.containing(.staticText, identifier:"White Chocolate Cherry Hand Pies")/*@START_MENU_TOKEN@*/.staticTexts["TRY"]/*[[".buttons[\"TRY\"].staticTexts[\"TRY\"]",".staticTexts[\"TRY\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        tablesQuery.children(matching: .cell).element(boundBy: 0).tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ingredients"]/*[[".otherElements[\"Ingredients\"].staticTexts[\"Ingredients\"]",".staticTexts[\"Ingredients\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Instructions"]/*[[".otherElements[\"Instructions\"].staticTexts[\"Instructions\"]",".staticTexts[\"Instructions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    
//    let firstRowIndex = tablesQuery.children(matching: .cell).
          // Line 2
    tablesQuery.cells.element(boundBy: 0).tap()
          // Line 3
          
    
//
    }
    
    func testLikedRecipesButtonUITestsAndDeleteAllLikedRecipes() throws {
        
        let app = XCUIApplication()
//        app.launch()

        app.buttons["bookmark"].tap()

        let likedRecipesNavigationBar = app.navigationBars["Liked Recipes"]
        let navigationBarTitle = "Liked Recipes"
        XCTAssertTrue(likedRecipesNavigationBar.staticTexts["Liked Recipes"].exists)
        let junkButton = likedRecipesNavigationBar.buttons["junk"]
        junkButton.tap()
        let elementsQuery = app.alerts["Remove all Recipes ?"].scrollViews.otherElements
        elementsQuery.buttons["Yes"].tap()
        app.navigationBars["Liked Recipes"].staticTexts["Liked Recipes"].swipeDown()
////        sleep(5)
//        app.buttons["bookmark"].tap()
//
//        XCTAssertTrue(app.tables.children(matching: .cell).count == 0)
                        
        
    }
    
}
