//
//  IntroView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/1/25.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack {
            Text("Budget Tracker")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.vertical)
            
            Text("Ready to track your spendings?")
                .foregroundColor(.white)
                .font(.system(.title2, design: .rounded))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // make it fill screen
        .background(Color.mint)
        .ignoresSafeArea() // Extends beyond the edges
    }
}
    
#Preview {
    IntroView()
}
