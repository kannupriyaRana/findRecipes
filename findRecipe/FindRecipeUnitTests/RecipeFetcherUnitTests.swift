
import XCTest

@testable import findRecipe

class RecipeFetcherUnitTests: XCTestCase {
    
    var recipeFetcherObject: RecipeFetcher!
    let session = URLSession.shared
    
    override func setUpWithError() throws {
        
        recipeFetcherObject = RecipeFetcher(UITableView())
    }
    
    override func tearDownWithError() throws {
        recipeFetcherObject = nil
    }
    // all tests are correct
//    func testValidApiCallForRandomRecipesGetsHTTPStatusCode200() throws {
//        let urlString = recipeFetcherObject.completeURL()
//        let url = URL(string: urlString)!
//        let promise = expectation(description: "Status code: 200")
//        let dataTask = session.dataTask(with: url) { _, response, error in
//            if let error = error {
//                XCTFail("Error: \(error.localizedDescription)")
//                return
//            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                if statusCode == 200 {
//                    promise.fulfill()
//                } else {
//                    XCTFail("Status code: \(statusCode)")
//                }
//            }
//        }
//        dataTask.resume()
//        wait(for: [promise], timeout: 5)
//    }
//
//    func testValidApiCallForRecipesByIngredientsGetsHTTPStatusCode200() throws {
//        measure(metrics: [XCTClockMetric(), // to measure time
//                                  XCTCPUMetric(), // to measure cpu cycles
//                         ]){
//            recipeFetcherObject.ingredientsPassed.append("apple")
//            let urlString = recipeFetcherObject.completeURL()
//            let url = URL(string: urlString)!
//            let promise = expectation(description: "Status code: 200")
//            let dataTask = session.dataTask(with: url) { _, response, error in
//                if let error = error {
//                    XCTFail("Error: \(error.localizedDescription)")
//                    return
//                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    if statusCode == 200 {
//                        promise.fulfill()
//                    } else {
//                        XCTFail("Status code: \(statusCode)")
//                    }
//                }
//            }
//            dataTask.resume()
//            wait(for: [promise], timeout: 5)
//        }
//
//    }
//
//    func testDecodeDataOfRandomRecipesFromAPIntoStructure() throws {
//
//        measure(metrics: [XCTClockMetric(), // to measure time
//                                  XCTCPUMetric(), // to measure cpu cycles
//                         ]) {
//            recipeFetcherObject.ingredientsPassed.removeAll()
//            let datastring = "{\"recipes\":[{\"vegetarian\":true,\"id\":642585,\"title\":\"Farfalle with fresh tomatoes, basil and mozzarella\",\"image\":\"https://spoonacular.com/recipeImages/642585-556x370.jpg\",\"imageType\":\"jpg\",}]}"
//            let safeData = datastring.data(using: .utf8)
//            do {
//                try recipeFetcherObject.decode(safeData!)
//            }
//            catch {
//                print(error)
//            }
//            var randomRecipe = recipeFetcherObject.randomRecipeResults[0]
//            XCTAssertEqual(randomRecipe.title, "Farfalle with fresh tomatoes, basil and mozzarella")
//            XCTAssertEqual(randomRecipe.id, 642585)
//            XCTAssertEqual(randomRecipe.vegetarian, true)
//        }
//
//    }
//
//    func testDecodeDataOfRecipeUsingIngredientsFromAPIntoStructure() throws {
//
//        measure(metrics: [XCTClockMetric(), // to measure time
//                          XCTCPUMetric(), // to measure cpu cycles
//                          XCTStorageMetric(), // to measure storage consuming
//                          XCTMemoryMetric()]){
//            recipeFetcherObject.ingredientsPassed.append("apple")
//            let datastring =
//            "{\"results\":[{\"id\":621189,\"usedIngredientCount\":1,\"missedIngredientCount\":2,\"likes\":0,\"title\":\"beetroot apple smoothie\",\"image\":\"https://spoonacular.com/recipeImages/621189-312x231.jpg\",\"imageType\":\"jpg\"}],\"offset\":0,\"number\":1,\"totalResults\":186}"
//            let safeData = datastring.data(using: .utf8)
//            do {
//                try recipeFetcherObject.decode(safeData!)
//            }
//            catch {
//                print(error)
//            }
//            var recipeFromIngredients = recipeFetcherObject.recipeResultsFromIngredients[0]
//            XCTAssertEqual(recipeFromIngredients.title, "beetroot apple smoothie")
//            XCTAssertEqual(recipeFromIngredients.id, 621189)
//            XCTAssertEqual(recipeFromIngredients.usedIngredientCount, 1)
//
//        }
//
//        recipeFetcherObject.ingredientsPassed.append("apple")
//        let datastring =
//        "{\"results\":[{\"id\":621189,\"usedIngredientCount\":1,\"missedIngredientCount\":2,\"likes\":0,\"title\":\"beetroot apple smoothie\",\"image\":\"https://spoonacular.com/recipeImages/621189-312x231.jpg\",\"imageType\":\"jpg\"}],\"offset\":0,\"number\":1,\"totalResults\":186}"
//        let safeData = datastring.data(using: .utf8)
//        do {
//            try recipeFetcherObject.decode(safeData!)
//        }
//        catch {
//            print(error)
//        }
//        var recipeFromIngredients = recipeFetcherObject.recipeResultsFromIngredients[0]
//        XCTAssertEqual(recipeFromIngredients.title, "beetroot apple smoothie")
//        XCTAssertEqual(recipeFromIngredients.id, 621189)
//        XCTAssertEqual(recipeFromIngredients.usedIngredientCount, 1)
//    }
}
