import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: AddExpenseViewModel
    @State private var isShowingDatePicker = false
    var date: Date
    var categoryType: CategoryType
    
    init(date: Date, categoryType: CategoryType) {
        self.date = date
        self.categoryType = categoryType
        _viewModel = StateObject(wrappedValue: AddExpenseViewModel(categoryType: categoryType))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(title: "Add expense", totalValue: nil)
                
                HStack {
                    Text("Cost:")
                        .font(.headline)
                        .foregroundColor(.primary)
    
                    TextField("Introduce the cost", text: $viewModel.cost)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                }
                .padding()
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Type:")
                        .font(.headline)
                        .foregroundColor(.primary)
    
                    Spacer()
                }
                .padding()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 10) {
                    ForEach(viewModel.defaultExpenses.indices, id: \.self) { index in
                        Button(action: {
                            if self.viewModel.selectedExpense == self.viewModel.defaultExpenses[index] {
                                self.viewModel.selectedExpense = nil
                            } else {
                                // De lo contrario, selecciona la imagen
                                self.viewModel.selectedExpense = self.viewModel.defaultExpenses[index]
                            }
                        }) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color(named: self.viewModel.defaultExpenses[index].colorName) ?? Color.gray.opacity(0.1))
                                        .frame(width: 55, height: 55)
                                    
                                    Image(systemName: self.viewModel.defaultExpenses[index].iconName)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                }
                                
                                Text(self.viewModel.defaultExpenses[index].title)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(self.viewModel.defaultExpenses[index] == self.viewModel.selectedExpense ? Color(named: self.viewModel.defaultExpenses[index].colorName) ?? Color.gray.opacity(0.1) : Color.clear)
                            .cornerRadius(10)
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Date:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(DateFormatterHelper.shared.format(date: self.viewModel.selectedDate))
                        .padding(.leading, 10)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShowingDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Comment:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                                    
                    HStack {
                        TextField("Introduce a comment", text: $viewModel.comment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Spacer()
                    }
                }
                .padding()
                
                Button(action: {
                    self.viewModel.actionAddExpense()
                }) {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(viewModel.isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(!viewModel.isFormValid)
                
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
            .blur(radius: isShowingDatePicker ? 2 : 0)
            
            if isShowingDatePicker {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isShowingDatePicker = false
                    }
                
                DatePickerPopup(selectedDate: self.$viewModel.selectedDate, isPresented: self.$isShowingDatePicker, date: date)
            }
        }
        .onChange(of: viewModel.saveCompleted) { saveCompleted in
            if saveCompleted {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    AddExpenseView(date: Date(), categoryType: CategoryType.ENTERTAINMENT)
}