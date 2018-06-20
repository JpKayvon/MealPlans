//
//  CustomerMeal.swift
//  MealPlan
//
//  Created by Shumei Kawagoe on 2018/06/11.
//  Copyright © 2018 Shumei Kawagoe. All rights reserved.
//

import Foundation

struct CustomerMeal {
    var firstName: String
    var lastName: String
    var email: String
    
    var startDate: Date
    var endDate: Date
    
    var numberOfPeople: Int
    
    var mealPlan: MealPlan
    var membership: Bool
}
