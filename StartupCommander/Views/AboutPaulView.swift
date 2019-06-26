//
//  AboutPaulView.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        Modified(content: self, modifier: TitleText())
    }
}

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineLimit(1)
    }
}

struct AboutPaulView : View {
    
    @EnvironmentObject var resume: Resume
    
    struct ContactInfoSectionView: View {
        @EnvironmentObject var resume: Resume
        var body: some View {
            Section(header: Text("Contact").titleStyle()) {
                ForEach(resume.contact) { contactInfo in
                    ContactMethodCell(contactInfo: contactInfo)
                }
            }
        }
    }
    
    struct ByLineSectionView: View {
        @EnvironmentObject var resume: Resume
        var body : some View {
            Section(header: Text("Software Developer").titleStyle()) {
                Text(resume.byline)
                    .font(.body)
                    .lineLimit(.none)
            }
        }
    }
    
    struct ResumeAccomplishmentsSectionView: View {
        @EnvironmentObject var resume: Resume
        var body: some View {
            Section(header: Text(resume.accomplisments).titleStyle()) {
                ForEach(resume.accomplismentsContent) { acc in
                    Text("- " + acc.value)
                        .font(.body)
                        .lineLimit(.max)
                        .padding(.leading)
                }
            }
        }
    }
    
    struct EducationSectionView: View {
        @EnvironmentObject var resume: Resume
        var body: some View {
            Section(header: Text(resume.education).titleStyle()) {
                Text(resume.educationContent)
                    .lineLimit(.none)
                    .font(.body)
            }
        }
    }
    
    struct ExpreienceSectionView: View {
        @EnvironmentObject var resume: Resume
        var body: some View {
            Section(header: Text("Experience").titleStyle()) {
                ForEach(resume.workExperience) { exp in
                    WorkExperienceCell(workExperience: exp)
                }
            }
        }
    }
    
    var body: some View {
        Form {
            ContactInfoSectionView()
            ByLineSectionView()
            ResumeAccomplishmentsSectionView()
            ExpreienceSectionView()
            EducationSectionView()
            }
            .navigationBarTitle(
                Text("Paul Wood")
                    .font(.title))
    }
}

#if DEBUG
struct AboutPaulView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutPaulView()
            .environmentObject(Resume())
        }
    }
}
#endif
