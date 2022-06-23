//
//  RecipeStoreUnitTests.swift
//  findRecipeTests
//
//  Created by Administrator on 22/02/22.
//

import XCTest
@testable import findRecipe

//class RecipeStoreUnitTests: XCTestCase {
//
//    static var userDefaultKey = "UserDefaultsKeyForTesting"
//
//    override func setUpWithError() throws {
//    }
//
//    override func tearDownWithError() throws {
//        UserDefaults.standard.removeObject(forKey: RecipeStoreUnitTests.userDefaultKey)
//    }
//
//    //all tests are correct
//    func testAddBookmark() throws {
//        let option = XCTMeasureOptions()
//                option.iterationCount = 5
//        measure(metrics: [XCTCPUMetric(), // to measure cpu cycles
//                         ], options: option) {
//            let testRecipeId = 1
//            let testRecipeTitle = "pudding"
//            RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
//            let fetchedRecipes = RecipesStore.fetchBookmarkedRecipesFromUserDefaults( key: RecipeStoreUnitTests.userDefaultKey)
//            let found = fetchedRecipes.contains(testRecipeId)
//            XCTAssertTrue(found)
//        }
//
//    }
////
////    func testRemoveBookmark() throws {
////        let testRecipeId = 2
////        let testRecipeTitle = "pudding"
////        RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
////        RecipesStore.removeBookmark(id: 2, key: RecipeStoreUnitTests.userDefaultKey)
////        let fetchedRecipes = RecipesStore.fetchBookmarkedRecipesFromUserDefaults( key: RecipeStoreUnitTests.userDefaultKey)
////        let found = fetchedRecipes.contains(testRecipeId)
////        XCTAssertFalse(found)
////    }
////
//    func testIsBookmarked() throws {
//        let option = XCTMeasureOptions()
//                option.iterationCount = 5
//        measure(metrics: [XCTCPUMetric(), // to measure cpu cycles
//                         ], options: option) {
//            let testRecipeId = 2
//            let testRecipeTitle = "pudding"
//            RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
//            var found = RecipesStore.isBookmarked(id: testRecipeId, key: RecipeStoreUnitTests.userDefaultKey)
//            XCTAssertTrue(found)
//            RecipesStore.removeBookmark(id: 2, key: RecipeStoreUnitTests.userDefaultKey)
//            found = RecipesStore.isBookmarked(id: testRecipeId, key: RecipeStoreUnitTests.userDefaultKey)
//            XCTAssertFalse(found)
//        }
//
//    }
//
//}
//------before this, like previous

class RecipeStoreUnitTests: XCTestCase {

    static var userDefaultKey = "UserDefaultsKeyForTesting"
    
    override func setUp() {
    }

    override func tearDown() {

        // Make sure that our memory leak inspection is the last thing to happen
        defer { super.tearDown() }

        UserDefaults.standard.removeObject(forKey: RecipeStoreUnitTests.userDefaultKey)
    }

    

    //all tests are correct
    func testAddBookmark() throws {
        let option = XCTMeasureOptions()
                option.iterationCount = 5
        measure(metrics: [XCTCPUMetric(), // to measure cpu cycles
                         ], options: option) {
            let testRecipeId = 1
            let testRecipeTitle = "pudding"
            RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
            let fetchedRecipes = RecipesStore.fetchBookmarkedRecipesFromUserDefaults( key: RecipeStoreUnitTests.userDefaultKey)
            let found = fetchedRecipes.contains(testRecipeId)
            XCTAssertTrue(found)
        }
        
    }
//
//    func testRemoveBookmark() throws {
//        let testRecipeId = 2
//        let testRecipeTitle = "pudding"
//        RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
//        RecipesStore.removeBookmark(id: 2, key: RecipeStoreUnitTests.userDefaultKey)
//        let fetchedRecipes = RecipesStore.fetchBookmarkedRecipesFromUserDefaults( key: RecipeStoreUnitTests.userDefaultKey)
//        let found = fetchedRecipes.contains(testRecipeId)
//        XCTAssertFalse(found)
//    }
//
    func testIsBookmarked() throws {
        let option = XCTMeasureOptions()
                option.iterationCount = 5
        measure(metrics: [XCTCPUMetric(), // to measure cpu cycles
                         ], options: option) {
            let testRecipeId = 2
            let testRecipeTitle = "pudding"
            RecipesStore.addBookmark(id: testRecipeId, savedRecipeTitle: testRecipeTitle, key: RecipeStoreUnitTests.userDefaultKey)
            var found = RecipesStore.isBookmarked(id: testRecipeId, key: RecipeStoreUnitTests.userDefaultKey)
            XCTAssertTrue(found)
            RecipesStore.removeBookmark(id: 2, key: RecipeStoreUnitTests.userDefaultKey)
            found = RecipesStore.isBookmarked(id: testRecipeId, key: RecipeStoreUnitTests.userDefaultKey)
            XCTAssertFalse(found)
        }

    }

}


