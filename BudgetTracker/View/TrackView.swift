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
            
            // The budget available view
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .opacity(0.1)
                    .frame(height: 120)
                
                VStack {
                    Text("Budget Available")
                        .bold()
                        .padding(.bottom, 5)
                    
                    Text("$\(budget.totalBudget, specifier: "%.2f")")
                        .font(.title)
                        .bold()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            HStack {
                Text("Transactions")
                    .font(.title2)
                    .bold()
                
                Spacer()
            }
            .padding([.bottom, .horizontal])
            
            if budget.transactions.isEmpty {
                VStack {
                    Text("Let's add your first transaction! 💸")
                        .bold()
                        .padding(.top)
                    
                    Spacer()
                }
            } else {
                List {
                    ForEach(budget.transactions.sorted(by: { $0.date > $1.date })) { transaction in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(transaction.description)
                                    .bold()
                                
                                Spacer()
                                
                                let actionString = transaction.action == .spend ? "-" : "+"
                                Text("\(actionString)$\(transaction.amount, specifier: "%.2f")")
                            }
                            
                            HStack {
                                Text(transaction.date.formatted(.dateTime.month(.twoDigits).day(.twoDigits).year(.twoDigits)))
                                Spacer()
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete { offsets in
                        let sortedTransactions = budget.transactions.sorted(by: { $0.date > $1.date }) // Closures - read this carefully!
                        let itemsToDelete = offsets.map { sortedTransactions[$0] }
                        budget.transactions.removeAll { itemsToDelete.contains($0) }
                    }
                }
                .listStyle(.plain)
            }
        }
            .sheet(isPresented: $showForm) {
                InputFormView(budget: budget)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.hidden) // Adjusts the sheet size
                
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

#Preview {
    TrackView()
}
