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
    
    @State private var transactionDescription: String = ""
    @State private var spendingAmount: String = ""
    
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
        ScrollView {
            VStack {
                HStack{
                    Text("Enter Description")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                // Adding Description
                TextField("Type your description...", text: $transactionDescription)
                    .keyboardType(.default)
                    .textFieldStyle(.roundedBorder)
                    .padding([.horizontal, .bottom])
                //  .onSubmit {
                //      if transactionDescription.isEmpty ...
                // }
                
                // Adding Amount
                TextField("Add Amount", text: $spendingAmount)
            }
        }
    }
}

#Preview {
    TrackView()
}
