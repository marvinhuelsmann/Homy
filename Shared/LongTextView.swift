//
//  LongTextView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 21.02.21.
//

import SwiftUI

struct LongTextView: View {
    var title: String
    var upNote: String
    var longText: String
    
    var body: some View {
        VStack {
            
            Text(upNote)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            ScrollView {
            
            Text(longText)
                .padding(.leading, 32)
                .padding(.trailing, 32)
                
            }
        }
      
        .navigationTitle(title)
    }
}

struct LongTextView_Previews: PreviewProvider {
    static var previews: some View {
        LongTextView(title: "Test", upNote: "Test Note", longText: "This is a long text.")
            .preferredColorScheme(.dark)
    }
}
