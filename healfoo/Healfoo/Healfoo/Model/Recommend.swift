//
//  Recommend.swift
//  Healfoo
//
//  Created by Woody on 7/3/24.
//

import Foundation

// MARK: - Recommend
struct Recommend: Codable{
    let foodList: [FoodList]
    let materials, needVitamins: [String]
}

// MARK: - Result
struct FoodList: Codable{
    let food, vitamins, description: String
    let cosSim: Double
    
}
