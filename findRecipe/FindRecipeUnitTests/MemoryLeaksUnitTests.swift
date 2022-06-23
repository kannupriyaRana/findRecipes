//
//  MemoryLeaksUnitTests.swift
//  findRecipeTests
//
//  Created by Administrator on 28/03/22.
//

import XCTest
@testable import findRecipe


class MemoryLeaksUnitTests: XCTestCase {

    
    
    var createdObjects = [AnyObject?]()
//    passing a single object to check
    func checkForLeakingObjectsByPassingASingleInstance(_ obj : AnyObject) {
        addTeardownBlock { [weak obj] in
            XCTAssertNil(obj)
        }
    }

//    passing an array of objects to check
    func checkForLeakingObjectsByPassingAnArray() {
        for i in 0...(createdObjects.count - 1) {
            weak var obj = createdObjects[i]
            addTeardownBlock {
                XCTAssertNil(obj)
            }
        }
        for i in 0...(createdObjects.count - 1) {
            createdObjects[i] = nil
        }
        createdObjects.removeAll()
    }
    //passing variable number of arguments to check
    func checkForLeakingObjectsReceivingVariableNumberOfArguments(_ objects : AnyObject?...) {
        for i in 0...(objects.count - 1) {
            weak var obj = objects[i]
            addTeardownBlock {
                XCTAssertNil(obj)               //showing leak here
            }
        }
        for i in 0...(objects.count - 1) {
//            objects[i] = nil
        }
    }
    
    func checkForLeakingIbjectsByApendingIntoTheCreatedObjectArray(_ objects : AnyObject?...) {
        for i in 0...(objects.count - 1) {
            createdObjects.append(objects[i])
        }
        checkForLeakingObjectsByPassingAnArray()
    }
    
    class temp {
        var viewC : FirstScreenViewController?
    }
    
    func testAddTeardownBlock() {
        let vc = FirstScreenViewController()
        let b = temp()
        b.viewC = vc
        
        
        //correct : in any order
//        addTeardownBlock { [weak b] in
//            XCTAssertNil(b)
//        }
//        addTeardownBlock { [weak vc] in
//            XCTAssertNil(vc)
//        }
        
        addTeardownBlock { [weak b, weak vc] in
            XCTAssertNil(vc)
            XCTAssertNil(b)
        }
        
    }
    
    
override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    while createdObjects.count > 0 {
        if var lastElement = createdObjects.last {
            weak var weakReference = lastElement
            lastElement = nil
            createdObjects.removeLast()
            XCTAssertNil(weakReference, "Potential memory Leak found !")
        }
    }
}

    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//
//    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//        while createdObjects.count > 0 {
//            if var lastElement = createdObjects.last {
//                weak var weakReference = lastElement
//                lastElement = nil
//                createdObjects.removeLast()
//                XCTAssertNil(weakReference)
//
//            }
//        }
//
//    }
//
    
    func testFuncPrepareForFirstScreenViewController() {

        var firstScreenVC : FirstScreenViewController? = FirstScreenViewController()
        let tableView : UITableView? = UITableView()
        firstScreenVC?.tableView = tableView!
        let controllerForRecipeListTables : ControllerForRecipeListTables? = ControllerForRecipeListTables(tableView!)
        firstScreenVC?.myDelegate = controllerForRecipeListTables!
//        let mirror = Mirror(reflecting: firstScreenVC as Any)
//        var weakly = [Weak<AnyObject>]()
//                mirror.children.forEach { child in
//                    print("Found child ",child.label!," with value ",child.value)
//                    if let objectType = child.value as AnyObject? {
//                        weakly.append(Weak(value: objectType))
//                    }
//                }
//                print(weakly.count)
//        for i in 0...weakly.count-1 {
//            print((weakly[i].value)!)
//        }
//        firstScreenVC = nil
        let getCount = checkForLeakingViewController(uiVC: &firstScreenVC)
        XCTAssertEqual(getCount, 0)
    }
    
    func testAddIngVC() {
        var addIngVC : AddIngredientsTableViewController? = AddIngredientsTableViewController()
        let mirror = Mirror(reflecting: addIngVC)

        mirror.children.forEach { label, value in
            guard let propertyName = label else { return }

            // NOTE: If the value is something, e.g. not `nil` (a.k.a. not `Optional<Any>.none`),
            // then we have a potential leak.
            if case Optional<Any>.some(_) = value {
                XCTFail("\"\(propertyName)\" is a potential memory leak!")
            }
        }
        let getCount = checkForLeakingViewController(uiVC: &addIngVC)
        XCTAssertEqual(getCount, 0)
    }
    
    func checkIfMemoryLeak(obj : AnyObject?) {
        print(obj)
        addTeardownBlock {
            
            [weak obj] in
            XCTAssertNil(obj,"Object was not deallocated")
        }
    }
    
    func testLikedRecipesViewControllerMethodDeleteAllButtonPressed() {
        //must fail - failing ✓
        /*
         Here showing memory leak
         memory leak could be resolved by setting the "self" captured by the closure in
         DeleteAllButtonPressed as "weak self", but presenting other view controller requires self which
         ultimately is causing a leak
        */
        
        var likedRecipesViewController: LikedRecipesViewController?
        likedRecipesViewController = LikedRecipesViewController()
        var tableView = UITableView()
        likedRecipesViewController?.tableView = tableView
//        likedRecipesViewController?.DeleteAllButtonPressed(UIBarButtonItem())
        checkIfMemoryLeak(obj: likedRecipesViewController)
        
//        addTeardownBlock {
//            
//            [weak likedRecipesViewController] in
//            XCTAssertNil(likedRecipesViewController,"Object was not deallocated")
//        }
        
//        weak var newLikedVC = likedRecipesViewController
//        likedRecipesViewController = nil
//        XCTAssertNil(newLikedVC)
        
    }
    
    func testLikedRecipesViewController() {
        //must pass - passing ✓
        
        var likedRecipesViewController: LikedRecipesViewController?
        likedRecipesViewController = LikedRecipesViewController()
        var tableView = UITableView()
        likedRecipesViewController?.tableView = tableView
//        likedRecipesViewController?.DeleteAllButtonPressed(UIBarButtonItem())
        weak var newLikedVC = likedRecipesViewController
        likedRecipesViewController = nil
        XCTAssertNil(newLikedVC)
        
    }
    
    
    
    func testLikedRecipesVCByAppendingAllCreatedObjectsIntoAnArray() {
        //must pass - passing ✓
        
        var likedRecipesViewController: LikedRecipesViewController?
        likedRecipesViewController = LikedRecipesViewController()
//        createdObjects.append(likedRecipesViewController)
        var tableView = UITableView()
//        createdObjects.append(tableView)
        likedRecipesViewController?.tableView = tableView
        checkForLeakingIbjectsByApendingIntoTheCreatedObjectArray(likedRecipesViewController,tableView)
//        checkForLeakingObjectsReceivingVariableNumberOfArguments(likedRecipesViewController,tableView)   ==> failing
//        addTeardownBlock {
//            <#code#>
//        }

//        likedRecipesViewController?.DeleteAllButtonPressed(UIBarButtonItem())
        
//        weak var newLikedVC = likedRecipesViewController
//        likedRecipesViewController = nil
//        XCTAssertNil(newLikedVC)
        
    }
    
    
    func testLikedRecipesVCMethodASPreviousButAddingAllObjectsInAnArray() {
        //must fail - failing ✓
        /*
         Here showing memory leak
         memory leak could be resolved by setting the "self" captured by the closure in
         DeleteAllButtonPressed as "weak self", but presenting other view controller requires self which
         ultimately is causing a leak
         */
        
        var likedRecipesViewController: LikedRecipesViewController?
        likedRecipesViewController = LikedRecipesViewController()
        createdObjects.append(likedRecipesViewController)
        var tableView = UITableView()
        createdObjects.append(tableView)
        likedRecipesViewController?.tableView = tableView
        likedRecipesViewController?.DeleteAllButtonPressed(UIBarButtonItem())
//        weak var newLikedVC = likedRecipesViewController
//        likedRecipesViewController = nil
//        XCTAssertNil(newLikedVC)
        }
    
   
}
