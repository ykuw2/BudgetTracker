//
//  TrackView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/4/25.
//

import SwiftUI

struct TrackView: View {
    @State private var showForm: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button(action:{
                    // to csv later on - some form of automatic download
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                }
                
                
                Spacer()
                Text("Tracking")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    showForm = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Divider()
            
            Spacer()
        }
        .sheet(isPresented: $showForm) {
            InputFormView()
        }
        
    }
}

// Put it into its own file later
struct InputFormView: View {
    @Environment(\.dismiss) var dismiss // Environment value that tells to close current view (across SwiftUI)
    var body: some View {
        Button(action: {
            dismiss()
        })
        {
            Text("Cancel")
        }
    }
}

#Preview {
    TrackView()
}
