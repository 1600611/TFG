//
//  ExpenseRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation

protocol ExpenseRepository {
    func fetchExpenses(date: Date, categoryType: String) -> [Expense]
}