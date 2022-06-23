//
//  AddIngredientUnitTests.swift
//  findRecipeTests
//
//  Created by Administrator on 22/02/22.
//

import XCTest
@testable import findRecipe

class AddIngredientUnitTests: XCTestCase {

    let keyForuserDefaults = "keyForTestingIngredientsSaved"
    var addINgredientsModelObject: AddIngredientsModel!
    
    override func setUp() {
        addINgredientsModelObject = AddIngredientsModel(keyForuserDefaults)
        addINgredientsModelObject.inputIngredientArray.append("apple")
        addINgredientsModelObject.inputIngredientArray.append("cheese")
        RecipesStore.updateUserDefaults(keyForuserDefaults , addINgredientsModelObject.inputIngredientArray)
    }
    
    override func tearDown() {
        addINgredientsModelObject.inputIngredientArray.removeAll()
        RecipesStore.updateUserDefaults(keyForuserDefaults , addINgredientsModelObject.inputIngredientArray)
        UserDefaults.standard.removeObject(forKey: keyForuserDefaults)
        
        
    }

    func testDeleteAllIngredientsMethodRemovesAllINgredientsFromUserDefaultsAndIngredientArray() {
        
        let option = XCTMeasureOptions()
                option.iterationCount = 5
        measure(metrics: [XCTCPUMetric()// to measure cpu cycles
                                  ], options: option) {
            addINgredientsModelObject.deleteAllIngredients(keyForuserDefaults)
            XCTAssertTrue(addINgredientsModelObject.inputIngredientArray.isEmpty)
            var fecthedIngredients: [String]?
            if let fetchFromUserDefauls = UserDefaults.standard.value(forKey: keyForuserDefaults) as? [String] {
                fecthedIngredients = fetchFromUserDefauls
            }
            else {
                fecthedIngredients = [String]()
            }
            XCTAssertTrue(fecthedIngredients!.count == 0)
        }
    }
    
    //correct
//    func testAddIngredientMethodAddsIngredientToUserDefaultAndIngredientArray() {
//        addINgredientsModelObject.addIngredient("butter", AddIngredientUnitTests.keyForuserDefaults)
//        XCTAssertTrue(addINgredientsModelObject.inputIngredientArray.contains("butter"))
//        let fecthedIngredients = UserDefaults.standard.value(forKey: AddIngredientUnitTests.keyForuserDefaults) as? [String]
//        XCTAssertTrue(fecthedIngredients!.contains("butter"))
//    }
    
    func testRemoveIngredientMethodRemovesIngredientFromUserDefaultsAndIngredientArray() {
        let option = XCTMeasureOptions()
                option.iterationCount = 5
        measure(metrics: [XCTCPUMetric(), // to measure cpu cycles
                         ], options: option) {
            addINgredientsModelObject.inputIngredientArray.append("butter")
            RecipesStore.updateUserDefaults(keyForuserDefaults , addINgredientsModelObject.inputIngredientArray)
            let lastIndex = addINgredientsModelObject.inputIngredientArray.count-1
            addINgredientsModelObject.removeIngredient(lastIndex, keyForuserDefaults)
            let fecthedIngredients = UserDefaults.standard.value(forKey: keyForuserDefaults) as? [String]
            XCTAssertFalse(fecthedIngredients!.contains("butter"))
            XCTAssertFalse(addINgredientsModelObject.inputIngredientArray.contains("butter"))
            
        }
        
        func testAdd() {
            let a = 2
            let b = 3
            let c = a + b
            XCTAssertEqual(c, 5)
        }
    }
    
}
