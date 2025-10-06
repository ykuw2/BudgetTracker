//
//  InputFormView.swift
//  BudgetTracker
//
//  Created by Yuki Kuwahara on 10/6/25.
//

import SwiftUI

struct InputFormView: View {
    @Environment(\.dismiss) var dismiss // Environment value that tells to close current view (across SwiftUI)

    @State private var paycheckAmount: String = ""
    
    var body: some View {
        
        HStack {
            TextField("Add Paycheck", text: $paycheckAmount)
            
            Button(action: {
                print("Hello")
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
            }
        }.padding()
        
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
