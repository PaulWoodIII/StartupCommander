//
//  Resume.swift
//  StartupCommander
//
//  Created by Paul Wood on 6/25/19.
//  Copyright © 2019 Paul Wood. All rights reserved.
//

import SwiftUI
import Combine

struct ContactInfo: Identifiable {
    var id: String {
        return type+value
    }
    let type: String
    let value: String
    let urlString: String
    var url: URL {
       return URL(string: urlString)!
    }
}

struct WorkExperience: Identifiable {
    var id: String {
        return employeer
    }
    let employeer: String
    let startTime: String
    let endTime: String
    let location: String
    let jobTitle: String
    let byline: String
    let accomplishments: [Accomplishment]
}

struct Accomplishment: Identifiable {
    var id = UUID()
    let value: String
}


class Resume: BindableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    
    let byline = """
    Proven Full-Stack global software Developer with solid experience working for Fortune 500 enterprises and start-ups. Demonstrated success working in a consultant lead development role and as an individual contributor for projects including cloud-based servers and embedded systems design with multi-platform mobile applications. Collaborative communicator, conversational in Chinese, capable of working with internal and external teams to deliver projects on time and aligned with requirements.
    """
    
    static let contactEmailUrlString = "mailto:paul.wood.iii@gmail.com"
    
    let contact: [ContactInfo] = [
        ContactInfo(type:"Email",
                    value:"paul.wood.iii@gmail.com",
                    urlString:contactEmailUrlString),
        ContactInfo(type:"Phone",
                    value:"843- 253-3496",
                    urlString:"tel:843- 253-3496"),
        ContactInfo(type:"Github",
                    value:"@PaulWoodiii",
                    urlString:"https://github.com/paulwoodiii"),
        ContactInfo(type:"Website",
                    value:"paulwoodiii.com",
                    urlString:"https://paulwoodiii.com"),
        ContactInfo(type:"LinkedIn",
                    value:"paulwood3",
                    urlString:"https://www.linkedin.com/in/paulwood3/"),
    ]
    
    let accomplisments = "Accomplishments"
    let accomplismentsContent: [Accomplishment] = [
        Accomplishment(value: "Designed and developed mobile Shipping iOS and Android apps with diverse goals, markets and locales."),
        Accomplishment(value: "Proven ability to lead and manage design and development projects with teams."),
        Accomplishment(value: "Designed and implemented mobile games, gamified shopping with iBeacons, wrote curriculum for adults learning their first programming language."),
    ]

    
    let education = "Education"
    let educationContent = "Bachelor of Arts, Computer Science and Chinese Language, Wofford College, Spartanburg, SC"
    
    let workExperience: [WorkExperience] = [
        WorkExperience(employeer: "Lowe’s Home Improvement",
                       startTime: "January 2017",
                       endTime: "Febuary 2019",
                       location: "Mooresville, NC",
                       jobTitle: "Senior Software Developer",
                       byline: "iOS Application developer for Iris, a smart home platform with over 180 connected devices.",
                       accomplishments: [
                        Accomplishment(value: "Implemented a number of complex User Interfaces and security features such as TouchID | FaceID, device pairing, streaming video and monitored alerts to ensure home protection.")
            ]),
        WorkExperience(employeer: "The Iron Yard",
                       startTime: "May 2016",
                       endTime: "Oct 2016",
                       location: "Charleston, SC",
                       jobTitle: "Mobile Instructor",
                       byline: "Lecture and mentor students to develop program engineering skills. ",
                       accomplishments: [
                        Accomplishment(value: "Refined the Mobile curriculum including creating true beginner learning materials for highly technical subjects resulting in achieving high student learning metrics.")]),
        WorkExperience(employeer: "Independent Consultant",
                       startTime: "2015",
                       endTime: "2016",
                       location: "Remote, USA",
                       jobTitle: "Application Development",
                       byline: "Redesigned and delivered Top 10 Fitness application’s user interface before the launch date under time constraints and strict specifications",
                       accomplishments: [
                        Accomplishment(value: "Remotely prototyped an upcoming application’s full stack using modern technologies and frameworks: Node.js, MongoDB and Swift.")]),
        WorkExperience(employeer: "Transmedia Creative Lab",
                       startTime: "2011",
                       endTime: "2015",
                       location: "Shanghai, China",
                       jobTitle: "Lead Developer",
                       byline: "As the third employee of Transmedia Creative Lab accountable for building user-facing websites and applications. ",
                       accomplishments: [
                        Accomplishment(value: "Built a social media application for a Social Local Mobile startup which focused on the retail customer experience using geolocation and augmented reality in the store. Specified an API for the application and fully developed the iOS application from the ground up."),
            Accomplishment(value: "Managed the entire user facing web and mobile application, programmers and deployment of those applications."),
            Accomplishment(value: "Collaborated with multiple external resources as the primary point of contact for game and web development.")
            ]),
        WorkExperience(employeer: "Red Rocket Games",
                       startTime: "2009",
                       endTime: "2011",
                       location: "Shanghai, China",
                       jobTitle: "Webmaster | Game Developer",
                       byline: "Created a website for an internationally published game on by Valve’s Steam platform and was promoted to game programmer creating some Top 100 iOS games. Worked as a remote committer on Gamefly, porting the app to iPad and adding social features.",
                       accomplishments: []),
        WorkExperience(employeer: "Additional Experience",
                       startTime: "Ongoing",
                       endTime: "",
                       location: "",
                       jobTitle: "Various Side-projects",
                       byline: "Always looking for the next big thing in life, mine or in others, and willing to lend a helping hand. Making quick but beautiful websites, prototyping apps, and contributing to open source software.",
                       accomplishments: [
                        Accomplishment(value: "Avid Cyclist that biked from Beijing to Shanghai."),
                            Accomplishment(value: "Built a Camper Van"),
            ]),
    ]
}


