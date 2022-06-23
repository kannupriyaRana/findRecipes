//
//  findRecipeUITestsLaunchTests.swift
//  findRecipeUITests
//
//  Created by Administrator on 24/02/22.
//

import XCTest
@testable import findRecipe

class LikedRecipeVCDeinitUITest: XCTestCase {


    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
    }
    
    
    func testLaunch() throws {
        
        
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["bookmark"].tap()

        let likedRecipesStaticText = app.navigationBars["Liked Recipes"].staticTexts["Liked Recipes"]
//        var topVC = topMostController()
//        print("printing topVC : ",topVC)
        likedRecipesStaticText.swipeDown()
//        XCTAssertEqual(Constants.deinitStatement, "Deinit of LikedRecipesViewController")
        
//
                                
    }
    
    
}
