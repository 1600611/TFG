//
//  MainViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

struct CategoryInformation: Identifiable, Equatable {
    let id = UUID()
    private var categoryType: CategoryType
    private var percentage: Int
    private var destinatedValue: Decimal
    private var spentValue: Decimal
    private var totalValue: Decimal
    
    init(categoryType: CategoryType, percentage: Int, destinatedValue: Decimal, spentValue: Decimal, totalValue: Decimal) {
        self.categoryType = categoryType
        self.percentage = percentage
        self.destinatedValue = destinatedValue
        self.spentValue = spentValue
        self.totalValue = totalValue
    }
    
    // Getters
    func getCategoryType() -> CategoryType {
        return categoryType
    }
    
    func getPercentage() -> Int {
        return percentage
    }
    
    func getDestinatedValue() -> Decimal {
        return destinatedValue
    }
    
    func getSpentValue() -> Decimal {
        return spentValue
    }
    
    func getTotalValue() -> Decimal {
        return totalValue
    }
}


import Foundation

@MainActor class MainViewModel: ObservableObject {
    @Published var categoriesInformation: [CategoryInformation] = []
    @Published var monthBenefit: Decimal = 0
    var categories: [Category] = []
    var income: Decimal = 1000
    
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository = MockCategoriesRepository()) {
        self.repository = repository
        getDistributions(date: Date())
    }
    
    func getDistributions(date: Date) {
        self.categories = repository.fetchCategories(date: date)
        actionIncomeChanged(income)
    }
    
    func actionIncomeChanged(_ newIncome: Decimal?) {
        for category in categories {
            let destinatedValue = newIncome! * Decimal(category.getPercentage()) / 100
            let spentValue = category.getSpentValue()
            let totalValue = destinatedValue - spentValue
            let categoryInfo = CategoryInformation(categoryType: category.getCategoryType(),
                                                   percentage: category.getPercentage(),
                                                   destinatedValue: destinatedValue,
                                                   spentValue: spentValue,
                                                   totalValue: totalValue)
            categoriesInformation.append(categoryInfo)
            monthBenefit += totalValue
        }
    }
    
}
