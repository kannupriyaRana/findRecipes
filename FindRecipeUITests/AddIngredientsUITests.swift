//
//  findRecipeUITests.swift
//  findRecipeUITests
//
//  Created by Administrator on 24/02/22.
//

import XCTest

class AddIngredientsUITests: XCTestCase {
    
    func testRemoveAllIngredients() throws {
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["search by ingredients"]/*[[".buttons[\"search by ingredients\"].staticTexts[\"search by ingredients\"]",".staticTexts[\"search by ingredients\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let findrecipeAddingredientstableviewNavigationBar = app.navigationBars["findRecipe.AddIngredientsTableView"]
        findrecipeAddingredientstableviewNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 0).tap()
        app.alerts["Remove all ingredients?"].scrollViews.otherElements.buttons["Yes"].tap()
        findrecipeAddingredientstableviewNavigationBar.children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
        let nextPageDisallowedAlert = app.alerts["No item added!"]
        XCTAssertTrue(nextPageDisallowedAlert.exists)
        app.alerts["No item added!"].scrollViews.otherElements.buttons["Ok"].tap()
        
    }
    
    func testAddIngredient() {
        
        let app = XCUIApplication()
        app.launch()
        
        let addNewIngredientButton = app.navigationBars["findRecipe.AddIngredientsTableView"].buttons["Add"]
        
        let alertTextField = app.alerts["Add ingredient"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Write here"]/*[[".cells.textFields[\"Write here\"]",".textFields[\"Write here\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let addButtonInAlert = app.alerts["Add ingredient"].scrollViews.otherElements.buttons["Add"]
        
        let addedCell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["cheese"]/*[[".cells.staticTexts[\"cheese\"]",".staticTexts[\"cheese\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                
        //flow of user actions in UI
        app.buttons["search by ingredients"].tap()
        addNewIngredientButton.tap()
        alertTextField.tap()
        alertTextField.typeText("cheese")
        XCTAssertFalse(addedCell.exists)
        addButtonInAlert.tap()
        XCTAssertTrue(addedCell.exists)
        addedCell.tap()
        app.alerts["Remove this item ?"].scrollViews.otherElements.buttons["Yes"].tap()
        XCTAssertFalse(addedCell.exists)
        
    }
    
    
    
}
