//
//  TrackView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI

struct TrackView: View {
    @State private var showForm: Bool = false
    @ObservedObject var budget = GlobalBudget()
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action:{
                    // to csv later on - some form of automatic download
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                }
                
                
                Spacer()
                Text("Tracking")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    showForm = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Divider()
            
            Spacer()
            
            Text("Budget Available: $\(budget.globalBudget, specifier: "%.2f")")
            Text("Total Rent Amount: $\(budget.totalRentAmount, specifier: "%.2f")")
            Text("Total Investment Amount: $\(budget.totalInvestmentAmount, specifier: "%.2f")")
            Text("Total Savings Amount: $\(budget.totalSavingsAmount, specifier: "%.2f")")
            
        }
        .sheet(isPresented: $showForm) {
            InputFormView(budget: budget)
        }
        
    }
}

#Preview {
    TrackView()
}
