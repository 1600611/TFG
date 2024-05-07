//
//  MockCaregoryRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockCategoryRepository: Category {
    func fetchCategories(date: Date) -> [Category] {
        let needsCategory = Category(categoryType: "NEEDS", percentage: 0, spentValue: 0)
        let entertainmentCategory = Category(categoryType: "ENTERTAINMENT", percentage: 0, spentValue: 0)
        let investmentsCategory = Category(categoryType: "INVESTMENTS", percentage: 0, spentValue: 0)
        let savingsCategory = Category(categoryType: "SAVINGS", percentage: 0, spentValue: 0)

        return [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
    }
    
    func save(categories: [Category], date: Date) {
        //CDCategory.deleteAll()
        //CDCategory.saveOrUpdate(categoryInformations: categoriesInformation, date: date)
    }
}