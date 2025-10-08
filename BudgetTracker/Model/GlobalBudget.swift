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
    
    // The total amounts of each category
    @Published var totalPaycheckAmount: Double = 0.0
    @Published var totalRentAmount: Double = 0.0
    @Published var totalInvestmentAmount: Double = 0.0
    @Published var totalSavingsAmount: Double = 0.0
    
    // Values to be stored for CSV
    @Published var paycheckAmountList: [Double] = []
    @Published var investAmountList: [Double] = []
    @Published var rentAmountList: [Double] = []
    @Published var savingsAmountList: [Double] = []
}
