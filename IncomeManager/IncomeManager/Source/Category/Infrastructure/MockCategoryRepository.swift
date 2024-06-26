//
//  MockCaregoryRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockCategoryRepository: CategoryRepository {
    func fetchCategories(date: Date) -> [Category] {
        let needsCategory = Category(categoryType: "NEEDS", percentage: 40, spentValue: 10)
        let entertainmentCategory = Category(categoryType: "ENTERTAINMENT", percentage: 20, spentValue: 50)
        let investmentsCategory = Category(categoryType: "INVESTMENTS", percentage: 20, spentValue: 0)
        let savingsCategory = Category(categoryType: "SAVINGS", percentage: 20, spentValue: 0)

        return [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
    }
    
    func save(categories: [Category], date: Date) {
        // Do nothing
    }
    
    func updateSpentValue(categoryType: CategoryType, spentValue: Decimal, date: Date) {
        // Do nothing
    }
}
