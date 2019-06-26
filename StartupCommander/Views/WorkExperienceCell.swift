//
//  WorkExperienceCell.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

struct WorkExperienceCell : View {
    let workExperience: WorkExperience
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workExperience.employeer)
                .font(.headline)
            
            Text( workExperience.endTime != "" ? workExperience.startTime + " - " + workExperience.endTime : workExperience.startTime)
                .font(.subheadline)
            
            Text(workExperience.jobTitle)
                .font(.subheadline)
            
            Text(workExperience.byline)
                .lineLimit(.max)
            
            ForEach(workExperience.accomplishments) { acc in
                Text("- " + acc.value)
                    .font(.body)
                    .lineLimit(.max)
                    .padding(.leading)
            }

        }
    }
}

#if DEBUG
struct WorkExperienceCell_Previews : PreviewProvider {
    static var previews: some View {
        WorkExperienceCell(workExperience: Resume().workExperience.first!)
    }
}
#endif
