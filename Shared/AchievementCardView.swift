//
//  AchievementCarf.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 21.03.21.
//

import SwiftUI

struct AchievementCardView: View {
    /// the name from the AchievementTypes
    var type: String
    /// the headline name of the card
    var headLine: String
    /// the bodytext from the card
    var bodyText: String
    
    var body: some View {
      
                VStack {
                    Text(headLine)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    
                    Text(bodyText)
                        .foregroundColor(.white)
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 275, height: 100)
                .padding()
                .background(getColorOfAchievementType(type: type))
                .cornerRadius(10)
                .shadow(radius: 5)
        
    }
}

struct AchievementsCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(type: AchievementsType.finishHomeWorks.rawValue, headLine: "HeadLine", bodyText: "This is an body text")
    }
}
