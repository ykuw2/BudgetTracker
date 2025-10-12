//
//  InputFormView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/6/25.
//

import SwiftUI

struct InputFormView: View {
    @Environment(\.dismiss) var dismiss // Environment value that tells to close current view (across SwiftUI)
    @ObservedObject var budget = GlobalBudget()
    
    @State private var transactionDate: Date = Date()
    @State private var transactionDescription: String = ""
    @State private var spendingAmountString: String = "" // We want this to be string so if user enters nothing by accident we can set to 0 and will not break
    @State private var transactionAction: TransactionAction = .spend
    @State private var transactionCategory: TransactionType = .shopping
    
    var body: some View {
        // "Add Transaction" Text on Top
        HStack{
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .font(.system(size: 15))
                    .foregroundColor(.red)
                    .padding(.leading, 5)
            }
            Spacer()
            Text("Add Transaction")
                .font(.title)
                .bold()
            Spacer()
            Button(action: {
                if let value = Double(spendingAmountString) {
                    let newTransaction = Transaction(
                        description: transactionDescription,
                        amount: value,
                        action: transactionAction,
                        category: transactionCategory,
                        date: transactionDate
                    )
                    budget.transactions.append(newTransaction)
                    transactionDate = Date()
                    spendingAmountString = ""
                    transactionDescription = ""
                    transactionAction = .spend
                    transactionCategory = .shopping
                }
                dismiss()
            }) {
                Text("Done")
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                    .padding(.trailing, 5)
            }
        }.padding([.top, .horizontal])
        
        Divider()
        
        // The transaction date
        VStack {
            HStack{
                Text("Enter Date")
                    .font(.title2)
                    .bold()
                Spacer()
            }
        
            .padding([.horizontal, .top])
            
            // Adding Date
            DatePicker("Select Date", selection: $transactionDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding([.horizontal, .bottom])
        
        // The content to add values
            HStack{
                Text("Enter Description")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top])
            
            // Adding Description
            TextField("Enter your description (Ex: Coffee)", text: $transactionDescription)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal, .bottom])

            
            // Adding Amount
            HStack {
                Text("Add Amount")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top])
            
            TextField("Enter your amount (Ex: $12.91)", text: $spendingAmountString)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding([.horizontal, .bottom])
            
            // Spend or Receive
            HStack {
                Text("Spend or Receive")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top])
            
            Picker("Spend or Receive", selection: $transactionAction) {
                ForEach(TransactionAction.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            
            // Category
            HStack {
                Text("Pick your category")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding([.horizontal, .top])
            
            Picker("Select Category", selection: $transactionCategory) {
                ForEach(TransactionType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 200)
            .padding(.horizontal)
            .clipped()
            }
        }
    }

#Preview {
    TrackView()
}
