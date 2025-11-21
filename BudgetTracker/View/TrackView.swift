//
//  TrackView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI
import UIKit

struct TrackView: View {
    @ObservedObject var budget = GlobalBudget()
    @State private var showForm: Bool = false
    @State private var showNoTransactionAlert: Bool = false
    @State private var showNoTransactionToDeleteAlert: Bool = false
    @State private var showClearAlert: Bool = false
    @State private var showShare: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Menu {
                    if let url = budget.exportCSVFile() {
                        ShareLink(item: url) {
                            Label("Export Transactions", systemImage: "square.and.arrow.up")
                        }
                    } else {
                        Button {
                            showNoTransactionAlert = true
                        } label: {
                            Label("Export Transactions", systemImage: "square.and.arrow.up")
                        }
                    }

                    Button {
                        if budget.transactions.isEmpty {
                            showNoTransactionToDeleteAlert = true
                        } else {
                            showClearAlert = true
                        }
                    } label: {
                        Label("Clear Transactions", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "gearshape")
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
            .alert("No transactions to export!", isPresented: $showNoTransactionAlert) {
                Button("Ok", role: .cancel) { }
            }
            .alert("No transactions to delete!", isPresented: $showNoTransactionToDeleteAlert) {
                Button("Ok", role: .cancel) { }
            }
            .alert("Are you sure you want to clear all transactions?", isPresented: $showClearAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete All", role: .destructive) {
                    budget.transactions.removeAll()
                }
            }
            
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
                            
                            HStack {
                                Text(transaction.category.rawValue)
                                    .font(.caption)
                                    .padding(5)
                                    .background(.gray.opacity(0.2))
                                    .cornerRadius(6)
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                            .font(.subheadline)
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
