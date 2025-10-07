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
    
    @State private var paycheckAmountList: [Double] = []
    @State private var paycheckAmount: String = ""
    
    @State private var investmentAmountList: [Double] = []
    @State private var investmentAmount: String = ""
    
    @State private var savingsAmountList: [Double] = []
    @State private var savingsAmount: String = ""
    
    var totalPaycheckAmount: Double {
        paycheckAmountList.reduce(0, +)
    }

    var totalInvestmentAmount: Double {
        investmentAmountList.reduce(0, +)
    }

    var totalSavingsAmount: Double {
        savingsAmountList.reduce(0, +)
    }

    var budgetAmount: Double {
        totalPaycheckAmount - (totalInvestmentAmount + totalSavingsAmount)
    }
    
    var body: some View {
        
        VStack {
            // Paycheck Section
        
            Text("Calculate your Budget")
                .font(.title)
                .bold()
                .padding(.bottom, 30)
            
            HStack {
                Text("Total Paycheck (Post Tax)")
                    .font(.title2)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                TextField("Add Paycheck Amount", text: $paycheckAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    guard !paycheckAmount.isEmpty else { return }
                    guard Double(paycheckAmount) != nil else { return }
                    
                    if let value = Double(paycheckAmount) {
                        paycheckAmountList.append(value)
                        paycheckAmount = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }.padding()
            
            ForEach(paycheckAmountList.indices, id: \.self) { i in
                HStack {
                    Text("Paycheck \(i + 1)")
                    Text("$\(paycheckAmountList[i], specifier: "%.2f")")
                }
            } .onDelete { offsets in
                paycheckAmountList.remove(atOffsets: offsets)
            }
            
            Text("Total Paycheck Amount: $\(totalPaycheckAmount, specifier: "%.2f")")
                .padding()
            
            // Investment
            
            HStack {
                Text("Investments")
                    .font(.title2)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                TextField("Add Investment Amount", text: $investmentAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    guard !investmentAmount.isEmpty else { return }
                    guard Double(investmentAmount) != nil else { return }
                    
                    if let value = Double(investmentAmount) {
                        investmentAmountList.append(value)
                        investmentAmount = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }.padding()
            
            ForEach(investmentAmountList.indices, id: \.self) { i in
                HStack {
                    Text("Investment \(i + 1)")
                    Text("$\(investmentAmountList[i], specifier: "%.2f")")
                }
            } .onDelete { offsets in
                investmentAmountList.remove(atOffsets: offsets)
            }
            
            Text("Total Investment Amount: $\(totalInvestmentAmount, specifier: "%.2f")")
                .padding()
            
            // Savings
            HStack {
                Text("Savings")
                    .font(.title2)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                TextField("Add Savings Amount", text: $savingsAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: {
                    guard !savingsAmount.isEmpty else { return }
                    guard Double(savingsAmount) != nil else { return }
                    
                    if let value = Double(savingsAmount) {
                        savingsAmountList.append(value)
                        savingsAmount = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }.padding()
            
            ForEach(savingsAmountList.indices, id: \.self) { i in
                HStack {
                    Text("Investment \(i + 1)")
                    Text("$\(savingsAmountList[i], specifier: "%.2f")")
                }
            } .onDelete { offsets in
                savingsAmountList.remove(atOffsets: offsets)
            }
            
            Text("Total Investment Amount: $\(totalSavingsAmount, specifier: "%.2f")")
                .padding()
            
            // Total Amount
            Text("Budget available for use: $\(budgetAmount, specifier: "%.2f")")
                .padding()
                .font(.title3)
                .bold()
            
            // TODO: Add cancel which discards all values and done where it saves the values
            // TODO: Refactor the code to reduce reptitiveness
            // TODO: Color and styling!
            Button(action: {
                dismiss()
            })
            {
                Text("Cancel")
            }
        }
        .onAppear{
            budget.globalBudget = budgetAmount
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil, from: nil, for: nil
                    )
                }
            }
        }
    }
}

#Preview {
    TrackView()
}
