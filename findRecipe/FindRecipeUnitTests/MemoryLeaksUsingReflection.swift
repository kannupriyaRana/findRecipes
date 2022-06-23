//
//  MemoryLeaksUsingReflection.swift
//  findRecipeTests
//
//  Created by Administrator on 13/06/22.
//

import XCTest

class MemoryLeaksUsingReflection: XCTestCase {
    var weakReferences = [WeakReference]()
    override func setUp() {
        super.setUp()
        addTeardownBlock { [unowned self] in
            let mirror = Mirror(reflecting: self)
            mirror.children.forEach { label, wrappedValue in
                guard let propertyName = label, self.hasSomeValue(wrappedValue)
                else {
                    return
                }

                let unwrappedValue = self.unwrap(wrappedValue)
                if Mirror(reflecting: unwrappedValue).displayStyle == .class {
                    weakReferences.append(WeakReference(objectValue: unwrappedValue as AnyObject, property: propertyName))
                }
            }
        }
    }
    override func tearDownWithError() throws {
        for weakReference in weakReferences {
            XCTAssertNil(weakReference.objectValue, "\(weakReference.propertyName!) is a potential memory leak")
        }
    }
    func hasSomeValue(_ wrappedValue: Any) -> Bool {
        if case Optional<Any>.some(_) = wrappedValue {
            return true
        }
        return false
    }
    func unwrap<T>(_ any: T) -> Any {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional, let first = mirror.children.first else {
            return any
        }
        return unwrap(first.value)
    }
}
