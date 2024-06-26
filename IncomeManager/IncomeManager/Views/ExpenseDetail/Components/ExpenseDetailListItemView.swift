//
//  ExpenseDetailListItemView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct ExpenseDetailListItemView: View {
    var expense: Expense
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: expense.getType().iconName)
                .resizable()
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(expense.getDescription())
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Text(DecimalFormatter.shared.format(expense.getAmount()) + "€")
                .foregroundColor(.black)
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color(named: expense.getType().colorName) ?? Color.gray.opacity(0.1))
                .cornerRadius(10)
                .frame(height: 70)
        )
    }
}

struct ExpenseDetailListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = Expense(id: UUID(), description: "de locos", amount: Decimal(100), type: "Food", categoryType: "Entertainment", date: Date())
        ExpenseDetailListItemView(expense: expense)
    }
}
