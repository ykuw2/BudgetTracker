//
//  OverView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI

struct OverView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Overview")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
            
            Divider()
            
            Spacer()
        }
    }
}

#Preview {
    OverView()
}
