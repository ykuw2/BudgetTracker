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
    
    // Clean up later
    @State private var paycheckAmountList: [Double] = []
    @State private var paycheckAmount: Double = 0.0
    
    @State private var rentAmountList: [Double] = []
    @State private var rentAmount: Double = 0.0
    
    @State private var investmentAmountList: [Double] = []
    @State private var investmentAmount: Double = 0.0
    
    @State private var savingsAmountList: [Double] = []
    @State private var savingsAmount: Double = 0.0
    
    @State private var shoppingAmountList: [Double] = []
    @State private var shoppingAmount: Double = 0.0
    
    @State private var foodAndDrinksList: [Double] = []
    @State private var foodAndDrinksAmount: Double = 0.0

    @State private var transportationAmountList: [Double] = []
    @State private var transportationAmount: Double = 0.0
    
    @State private var servicesAmountList: [Double] = []
    @State private var servicesAmount: Double = 0.0
    
    @State private var entertainmentAmountList: [Double] = []
    @State private var entertainmentAmount: Double = 0.0
    
    @State private var transfersAmountList: [Double] = []
    @State private var transfersAmount: Double = 0.0
    
    @State private var transactionDescription: String = ""
    @State private var spendingAmountString: String = "" // We want this to be string so if user enters nothing by accident we can set to 0 and will not break
    @State private var transactionAction: TransactionAction = .spend
    @State private var category: TransactionType = .shopping
    
    // Change this later
    var totalBudget: Double {
        paycheckAmountList.reduce(0, +) +
        rentAmountList.reduce(0, +) +
        investmentAmountList.reduce(0, +) +
        savingsAmountList.reduce(0, +) +
        shoppingAmountList.reduce(0, +) +
        foodAndDrinksList.reduce(0, +) +
        transportationAmountList.reduce(0, +) +
        servicesAmountList.reduce(0, +) +
        entertainmentAmountList.reduce(0, +) +
        transfersAmountList.reduce(0, +)
    }

    
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
                budget.globalBudget = totalBudget
                
                dismiss()
            }) {
                Text("Done")
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                    .padding(.trailing, 5)
            }
        }.padding([.top, .horizontal])
        
        Divider()
        
        // The content to add values
        VStack {
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
            
            Picker("Select Category", selection: $category) {
                ForEach(TransactionType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            .padding(.horizontal)
            .clipped()
            }
        }
    }

#Preview {
    TrackView()
}
