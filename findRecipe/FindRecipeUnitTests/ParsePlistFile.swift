//
//  ParsePlistFile.swift
//  findRecipe
//
//  Created by Administrator on 02/03/22.
//

import Foundation


/*
 Reading data from Property List
 1) Find URL of plist file
 2) Create data from content of URL
 3) Decode data and get the settings(info you like to access)
 4) Update the UI(or test the flow)
*/

//struct TempPlistFile: Codable {
//    var color: Int
//    var image: String
//}

struct testPlistFile: Codable {
    var cpuCycles: Int
}


class ParseplistFile {
    
    static func showSettings() {
        if let settings = getSettings() {
            let cpuCycles = settings.cpuCycles
            print("\(cpuCycles) is cpuCycle ")
        }
    }
    
    static func getSettings() -> testPlistFile? {
        let decoder = PropertyListDecoder()
        let url = Bundle.main.url(forResource: "7270C6BB-FC92-4790-AB38-E977E8599516", withExtension: "plist")!
        
        print("reached plist file")

        if let data = try? Data(contentsOf: url) {
            if let settings = try? decoder.decode(testPlistFile.self, from: data) {
                return settings
            }
        }
        return nil
        
    }
    
    
    
    
    static func getPlistValues() {
        var config: [String: Any]?
        if let infoPlistPath = Bundle.main.url(forResource: "7270C6BB-FC92-4790-AB38-E977E8599516", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)

                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
//                    let diffClassNames =



                }
            } catch {
                print(error)
            }
        }
        else{
            print("couldn't reach plist file")
        }
    }
    
}


