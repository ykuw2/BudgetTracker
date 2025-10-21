//
//  TrackView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI
import UIKit

struct TrackView: View {
    @State private var showForm: Bool = false
    @ObservedObject var budget = GlobalBudget()
    @State private var showNoTransactionAlert = false
    @State private var exportURL: ShareableURL?
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action: {
                    if let url = budget.exportCSVFile() {
                        exportURL = ShareableURL(url: url)
                    } else {
                        showNoTransactionAlert = true
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                }
                .alert("No transactions to export!", isPresented: $showNoTransactionAlert) {
                    Button("Ok", role: .cancel) {
                    }
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
            .sheet(item: $exportURL) { item in // exportURL needs to conform Identifiable
                ShareSheet(items: [item.url]) // Sheet appears because non-nil state which in my first iteration was the flaw that wasn't implemented
            }
        
    }
}

// Struct wrapper for share sheet
struct ShareSheet: UIViewControllerRepresentable { // Standard iOS share sheet
    let items: [Any] // The item to share
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil) // Standard iOS share sheet
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {} // SwiftUI's way to propogate state changes in UIKit
}

// URL Wrapper that has UUID so that it can track the unique ID
struct ShareableURL: Identifiable {
    let id = UUID() // UUID guarantees new sheet everytime leading to non-nil (new ID)
    let url: URL
}


#Preview {
    TrackView()
}
