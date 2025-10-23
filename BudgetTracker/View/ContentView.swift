//
//  ContentView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        VStack(spacing: 0) {
            if selection == 0 {
                TrackView()
            } else {
                OverView()
            }

            HStack(spacing: 0) {
                Button(action: {
                    selection = 0
                }) {
                    Text("Tracking")
                        .frame(maxWidth: .infinity,  maxHeight: .infinity)
                        .padding()
                        .background(selection == 0 ? Color.mint: Color.gray.opacity(0.2)) // Ternary operator if x ? (then) : else
                        .foregroundColor(selection == 0 ? .white : .primary)
                }
                Button(action: {
                    selection = 1
                }) {
                    Text("Overview")
                        .frame(maxWidth: .infinity,  maxHeight: .infinity)
                        .padding()
                        .background(selection == 1 ? Color.mint : Color.gray.opacity(0.2)) // background color
                        .foregroundColor(selection == 1 ? .white : .primary) // text color
                }
            }
            .frame(height: 80)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
}

#Preview {
    ContentView()
}
