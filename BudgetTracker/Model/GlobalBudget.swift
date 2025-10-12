//
//  GlobalBudget.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/7/25.
//

import Combine
import SwiftUI

class GlobalBudget: ObservableObject {
    // Budget able to be used
    @Published var globalBudget: Double = 0.0
    @Published var transactions: [Transaction] = []
    
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
}
