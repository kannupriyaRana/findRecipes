//
//  CommonFunctions.swift
//  findRecipe
//
//  Created by Administrator on 18/02/22.
//

import Foundation
import UIKit



func returnFailedAlert() -> UIAlertController {
    let failedNetworkCallAlert = UIAlertController(title: "Unable to fetch reipes", message: "Please force quit the app  and reopen it ", preferredStyle: UIAlertController.Style.alert)

    
    failedNetworkCallAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        return
    }))
    return failedNetworkCallAlert
}

func returnEmptyAlert() -> UIAlertController {
    let emptyArrayAlert = UIAlertController(title: "No item added!", message: "", preferredStyle: UIAlertController.Style.alert)

    emptyArrayAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        return
    }))
    return emptyArrayAlert
}

class Weak<T: AnyObject> {
  weak var value : T?
  init (value: T) {
    self.value = value
  }
}

func checkForLeakingViewController<T>(uiVC : inout T?) -> Int {
    let mirror = Mirror(reflecting: uiVC as Any)
    var weakly = [Weak<AnyObject>]()
            mirror.children.forEach { child in
                print("Found child ",child.label!," with value ",child.value)
                if let objectType = child.value as AnyObject? {
                    weakly.append(Weak(value: objectType))
                }
            }
            print(weakly.count)
    for i in 0...weakly.count-1 {
        print((weakly[i].value)!)
    }
    uiVC = nil
    return weakly.count
}
