//
//  TransactionTypes.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/8/25.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    var description: String = ""
    var amount: Double
    var action: TransactionAction
    var category: TransactionType
    var date: Date = Date()
}

enum TransactionType: String, CaseIterable {
    case paycheck = "Paycheck"
    case rent = "Rent"
    case investment = "Investment"
    case saving = "Saving"
    case shopping = "Shopping"
    case foodAndDrinks = "Food and Drinks"
    case transportation = "Transportation"
    case services = "Services"
    case entertainment = "Entertainment"
    case transfers = "Transfers"
}

enum TransactionAction: String, CaseIterable {
    case spend = "Spend"
    case receive = "Receive"
}
