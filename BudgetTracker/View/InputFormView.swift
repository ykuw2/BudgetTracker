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
    
    @State private var rentAmountList: [Double] = []
    @State private var rentAmount: String = ""
    
    @State private var investmentAmountList: [Double] = []
    @State private var investmentAmount: String = ""
    
    @State private var savingsAmountList: [Double] = []
    @State private var savingsAmount: String = ""
    
    var totalPaycheckAmount: Double {
        paycheckAmountList.reduce(0, +)
    }
    
    var totalRentAmount: Double {
        rentAmountList.reduce(0, +)
    }
    
    var totalInvestmentAmount: Double {
        investmentAmountList.reduce(0, +)
    }
    
    var totalSavingsAmount: Double {
        savingsAmountList.reduce(0, +)
    }
    
    var budgetAmount: Double {
        totalPaycheckAmount - (totalRentAmount + totalInvestmentAmount + totalSavingsAmount)
    }
    
    var body: some View {
        // Paycheck
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
            Text("Budget Calculator")
                .font(.system(size: 25))
                .bold()
            Spacer()
            Button(action: {
                budget.globalBudget = budgetAmount
                budget.rentAmountList = rentAmountList
                budget.investAmountList = investmentAmountList
                budget.savingsAmountList = savingsAmountList
                
                budget.totalRentAmount = totalRentAmount
                budget.totalInvestmentAmount = totalInvestmentAmount
                budget.totalSavingsAmount = totalSavingsAmount
                
                dismiss()
            }) {
                Text("Done")
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                    .padding(.trailing, 5)
            }
        }.padding([.top, .horizontal])
        
        Divider()
        
        ScrollView {
            VStack {
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
                        Spacer()
                        Text("$\(paycheckAmountList[i], specifier: "%.2f")")
                        Spacer()
                        Button(action: {
                            paycheckAmountList.remove(at: i)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                // Rent
                HStack {
                    Text("Rent")
                        .font(.title2)
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                HStack {
                    TextField("Add Rent Amount", text: $rentAmount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        guard !rentAmount.isEmpty else { return }
                        guard Double(rentAmount) != nil else { return }
                        
                        if let value = Double(rentAmount) {
                            rentAmountList.append(value)
                            rentAmount = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }.padding()
                
                ForEach(rentAmountList.indices, id: \.self) { i in
                    HStack {
                        Text("Rent \(i + 1)")
                        Spacer()
                        Text("$\(rentAmountList[i], specifier: "%.2f")")
                        Spacer()
                        Button(action: {
                            rentAmountList.remove(at: i)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                // Investment
                HStack {
                    Text("Investments")
                        .font(.title2)
                    
                    Spacer()
                }
                .padding([.horizontal, .top])
                
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
                        Spacer()
                        Text("$\(investmentAmountList[i], specifier: "%.2f")")
                        Spacer()
                        Button(action: {
                            investmentAmountList.remove(at: i)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                // Savings
                HStack {
                    Text("Savings")
                        .font(.title2)
                    Spacer()
                }
                .padding([.horizontal, .top])
                
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
                        Text("Savings \(i + 1)")
                        Spacer()
                        Text("$\(savingsAmountList[i], specifier: "%.2f")")
                        Spacer()
                        Button(action: {
                            savingsAmountList.remove(at: i)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                // Total Amount
                Text("Budget available for use: $\(budgetAmount, specifier: "%.2f")")
                    .padding()
                    .font(.title3)
                    .bold()
                
                // TODO: Refactor the code to reduce reptitiveness
                // TODO: Color and styling!
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
    }
}

#Preview {
    TrackView()
}
