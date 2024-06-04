//
//  ExpenseDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct ExpenseDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel = ExpenseDetailViewModel()
    var type: ExpenseType
    var date: Date
    var totalExpended: Decimal
    
    var body: some View {
        VStack() {
            HeaderView(title: type.title, totalValue: totalExpended, color: type.colorName)
      
            ScrollView {
                ForEach(viewModel.expenses.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text(DateFormatterHelper.shared.format(date: viewModel.expenses[index].getDate()))
                                .foregroundColor(0 == 0 ? Color.black : Color.white)
                            Spacer()
                        }
                        
                        ExpenseDetailListItemView(expense: viewModel.expenses[index])
                            .contextMenu {
                                Button(action: {
                                    viewModel.deleteExpense(viewModel.expenses[index])
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                        
                        Divider()
                            .background(0 == 0 ? Color.black : Color.white)
                            .padding(.top, 5)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 2)
                }
            }
            
            Spacer()
        }
        .background(0 == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
        .onAppear() {
            viewModel.onAppear(date, type)
        }
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = Expense(id: UUID(), description: "de locos", amount: Decimal(100), type: "Entertainment", categoryType: "Entertainment", date: Date())
        ExpenseDetailView(type: expense.getType(), date: expense.getDate(), totalExpended: expense.getAmount())
    }
}
