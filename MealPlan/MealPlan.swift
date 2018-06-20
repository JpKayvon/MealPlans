//
//  MealPlan.swift
//  MealPlan
//
//  Created by Shumei Kawagoe on 2018/06/11.
//  Copyright © 2018 Shumei Kawagoe. All rights reserved.
//

import Foundation

struct MealPlan: Equatable {
    
    static var choices: [MealPlan] {
        return [
        MealPlan(id: 0, name: "Strawberry boost", abbreviation: "SB", price: 3),
        MealPlan(id: 1, name: "Choco Macho", abbreviation: "CM", price: 5),
        MealPlan(id: 2, name: "Bananarama", abbreviation: "B", price: 2),
        MealPlan(id: 3, name: "Coconut Bro", abbreviation: "CB", price: 4)
        ]
    }
    
    var id: Int
    var name: String
    var abbreviation: String
    var price: Int
}

func ==(lhs: MealPlan, rhs: MealPlan)-> Bool {
    return lhs.id == rhs.id
}
