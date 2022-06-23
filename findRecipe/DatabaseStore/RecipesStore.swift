//
//  RecipesStored.swift
//  findRecipe
//
//  Created by Administrator on 17/02/22.
//
import UserNotifications

import Foundation


class RecipesStore{
    
    static func fetchBookmarkedRecipesFromUserDefaults(key: String) -> [Int] {
        if let idArray = UserDefaults.standard.object(forKey: key) as? [Int] {
            return idArray
        }
        return [Int]()
    }

    static func updateUserDefaults(_ key: String, _ itemList: [Any]) {
        UserDefaults.standard.set(itemList, forKey: key)
    }
    
    static func addBookmark(id: Int, savedRecipeTitle: String, key: String) {
        let notificationPublisher = NotificationPublisher()
        var bookmarkedRecipes = fetchBookmarkedRecipesFromUserDefaults(key: key)
        bookmarkedRecipes.append(id)
        RecipesStore.updateUserDefaults(key, bookmarkedRecipes)
        notificationPublisher.sendNotification(title: "New Recipe is saved !", subtitle: "Try out '\(savedRecipeTitle)' today !!", body: "", badge: 1, delayInterval: nil)
    }

    static func removeBookmark(id: Int, key: String) {
        var bookmarkedRecipes = fetchBookmarkedRecipesFromUserDefaults(key: key)
        bookmarkedRecipes = bookmarkedRecipes.filter { $0 != id }
        RecipesStore.updateUserDefaults(key, bookmarkedRecipes)

    }

    static func isBookmarked(id: Int, key: String) -> Bool {
        let bookmarkedRecipes = fetchBookmarkedRecipesFromUserDefaults( key: key)
        return bookmarkedRecipes.contains(id)
    }

}
