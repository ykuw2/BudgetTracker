//
//  AppView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/2/25.
//

import SwiftUI

struct AppView: View {
    @State private var showIntro: Bool = true
    @State private var opacity: Double = 0.0
    
    var body: some View {
        if showIntro {
            IntroView()
                .opacity(opacity)
                .transition(.move(edge: .leading))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showIntro = false
                        }
                    }
                }
            
        } else {
            ContentView()
        }
    }
}
