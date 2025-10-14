//
//  GlobalBudget.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/7/25.
//

import Combine
import SwiftUI

class GlobalBudget: ObservableObject {
    @Published var globalBudget: Double = 0.0 {
        didSet {
            saveData()
        }
    }
    
    @Published var transactions: [Transaction] = [] {
        didSet {
            saveData()
        }
    }
    
    // Calculating the total budget
    var totalBudget: Double {
        transactions.reduce(0) { total, txn in // running total (total) and current transaction (txn)
            switch txn.action {
            case .receive:
                return total + txn.amount
            case .spend:
                return total - txn.amount
            }
        }
    }
    
    // Initialization
    init() {
        loadData()
    }
    
    // Keys of where to store the data
    private let globalBudgetKey = "SavedGlobalBudget"
    private let transactionKey = "SavedTransactions"
    
    // Saving the data in UserDefaults
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(transactions) { // Encoding to JSON
            UserDefaults.standard.set(encoded, forKey: transactionKey) // Putting the list into the transactionKey
        }
        
        UserDefaults.standard.set(globalBudget, forKey: globalBudgetKey) // Putting the budget to the globalbudgetKey
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: transactionKey),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {  // Decoding
            transactions = decoded
        }
        
        globalBudget = UserDefaults.standard.double(forKey: globalBudgetKey)
    }
}
