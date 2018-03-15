//
//  Meal.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import Foundation

struct Meal: Codable {
    var weekday: Int
    var count: Int
    var rice: Int
    var meat: Int
    
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first!
    static func saveToFile(meals: [Meal]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(meals) {
            let url = Meal.documentsDirectory.appendingPathComponent("meal")
            try? data.write(to: url)
        }
    }
    
    static func readItemsFromFile() -> [Meal]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Meal.documentsDirectory.appendingPathComponent("meal")
        if let data = try? Data(contentsOf: url), let meals = try?
            propertyDecoder.decode([Meal].self, from: data) {
            return meals
        } else {
            return nil
        }
    }
    
}
