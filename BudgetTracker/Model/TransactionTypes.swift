//
//  TransactionTypes.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/8/25.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var description: String = ""
    var amount: Double
    var action: TransactionAction
    var category: TransactionType
    var date: Date = Date()
}

enum TransactionType: String, Codable, CaseIterable {
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
    
    var color: Color {
        switch self {
        case .paycheck: return .green
        case .rent: return .red
        case .investment: return .blue
        case .saving: return .purple
        case .shopping: return .pink
        case .foodAndDrinks: return .orange
        case .transportation: return .yellow
        case .services: return .brown
        case .entertainment: return .indigo
        case .transfers: return .mint
        }
    }
}

enum TransactionAction: String, Codable, CaseIterable {
    case spend = "Spend"
    case receive = "Receive"
}
