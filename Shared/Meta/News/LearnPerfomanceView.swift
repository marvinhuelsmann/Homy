//
//  LearnPerfomanceView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI

struct LearnPerfomanceView: View {
    var body: some View {
        
        LongTextView(title: "Performant lernen", upNote: "Um diesen Text zu lesen brauchst du 20 Minuten", longText: "This is a long Text very long!")
        
    }
}

struct LearnPerfomanceView_Previews: PreviewProvider {
    static var previews: some View {
        LearnPerfomanceView()
    }
}
