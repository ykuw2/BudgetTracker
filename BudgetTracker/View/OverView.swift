//
//  OverView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI
import UIKit
import Charts

struct PieChartView: View {
    var spending: [(category: TransactionType, amount: Double)]
    
    var body: some View {
        Chart(spending, id: \.category.rawValue) { item in
            SectorMark(
                angle: .value("Amount", item.amount),
            )
            .foregroundStyle(item.category.color)
        }
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
            
            if budget.spendingByCategory.isEmpty {
                Text("Add spendings to see the breakdown! 💸")
                    .bold()
                    .padding()
                
                Spacer()
            } else {
                
                PieChartView(spending: budget.spendingByCategory)
                
                Spacer()
                
                Text("Breakdown")
                    .bold()
                
                List {
                    ForEach(budget.spendingByCategory, id: \.category.rawValue) { item in
                        HStack{
                            Circle()
                                .fill(item.category.color)
                                .frame(width: 15)
                            Text(item.category.rawValue)
                            Spacer()
                            Text("$\(item.amount, specifier: "%.2f")")
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}
    

#Preview {
    OverView()
}
