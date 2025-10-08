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
            
            // The budget available button
            GeometryReader {geo in
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                            .opacity(0.1)
                            .frame(
                                width: geo.size.width * 0.45,
                                height: geo.size.height * 0.2
                                )
                        
                        VStack {
                            Text("Budget Available")
                                .bold()
                                .padding(.bottom)
                            
                            Text("$\(budget.globalBudget, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            Spacer()
        
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
