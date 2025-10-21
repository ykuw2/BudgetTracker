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
    
    // Calculating the amount in each category
    var spendingByCategory: [(category: TransactionType, amount: Double)] {
        var dict: [TransactionType: Double] = [:]
        for transaction in transactions where transaction.action == .spend {
            dict[transaction.category, default: 0] += transaction.amount
        }
        return dict.map{($0.key, $0.value)}
    }
    
    // Keys of where to store the data
    private let globalBudgetKey = "SavedGlobalBudget"
    private let transactionKey = "SavedTransactions"
    
    // Initialization
    init() {
        loadData()
    }
    
    // Function that makes the transaction items into String format
    func transactionsToCSV() -> String {
        // Header
        var csvString = "Date,Category,Description,Action,Amount\n"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for transaction in transactions {
            let dateString = formatter.string(from: transaction.date)
            let line = "\(dateString),\(transaction.category),\"\(transaction.description)\",\(transaction.action),\(transaction.amount)\n"
            
            csvString.append(line)
        }
        return csvString
    }
    
    // Function that actually writes this to a CSV
    func exportCSVFile() -> URL? { // URL is like a link or an address to a site or a file (path)
        guard !transactions.isEmpty else {
            print("You do not have any transactions to export.")
            return nil
        }
        
        let csvData = transactionsToCSV()
        
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("budgetTransactions.csv") // Adding to iOS file system and then adding it into short term file directory with the filename
        
        do { // Similar logic as try-catch in Python
            try csvData.write(to: fileURL, atomically: true, encoding: .utf8) // atomically here means write temporary then overwrite if necessary - and .utf8 is the standard format for text files
            return fileURL // returning the location of the saved file
        } catch {
            print("Error writing CSV \(error)")
            return nil // returns nil since "URL?" -> file was not able to be created
        }
    }
    
    // Saving the data in UserDefaults
    private func saveData() { // UserDefaults is for small storage and in dictionary format
        if let encoded = try? JSONEncoder().encode(transactions) { // Encoding to JSON (dictionary)
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
