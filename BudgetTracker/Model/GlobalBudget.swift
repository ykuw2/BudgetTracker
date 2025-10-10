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
}
