//
//  OverView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI
import Charts

struct BarView: View {
    var spending: [(category: TransactionType, amount: Double)]
    
    var body: some View {
            Chart(spending, id: \.category) { item in
                BarMark(
                    x: .value("Category", item.category.rawValue.capitalized),
                    y: .value("Amount", item.amount)
                )
                .foregroundStyle(.blue)
            }
            .frame(height: 200)
            .padding()
            
        }
    }

struct OverView: View {
    @ObservedObject var budget = GlobalBudget()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Overview")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            Divider()
            
            Spacer()
            
            BarView(spending: budget.spendingByCategory)
            
            Spacer()
        }
    }
}
#Preview {
    OverView()
}
