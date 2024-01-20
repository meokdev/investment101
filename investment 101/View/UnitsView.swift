//
//  UnitsView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI

struct Question: Equatable, Hashable {
    let text: String
    let answers: [String]
    let rightAnswer: String

    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.text == rhs.text
            && lhs.answers == rhs.answers
            && lhs.rightAnswer == rhs.rightAnswer
    }

    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        rightAnswer = correctAnswer
    }
}

struct Topic: Identifiable, Hashable {
    let id: Int
    let name: String
    let articleURL: URL // HTML file path in Downloads folder without extension
    let questions: [Question]
}

struct UnitsView: View {

    let unitview: [String: [Topic]] = [
        K.unit1: [
            Topic(id: 1, name: K.topic11, articleURL: K.article11URL, questions: K.quiz11),
            Topic(id: 2, name: K.topic12, articleURL: K.article12URL, questions: K.quiz12),
            Topic(id: 3, name: K.topic21, articleURL: K.article21URL, questions: K.quiz21),
            Topic(id: 4, name: K.topic22, articleURL: K.article22URL, questions: K.quiz22),
            Topic(id: 5, name: K.topic23, articleURL: K.article23URL, questions: K.quiz23),
            Topic(id: 6, name: K.topic24, articleURL: K.article24URL, questions: K.quiz24)
        ]
    ]
    
    
    let units: [String: [Topic]] = [
        K.unit1: [
            Topic(id: 1, name: K.topic11, articleURL: K.article11URL, questions: K.quiz11),
            Topic(id: 2, name: K.topic12, articleURL: K.article12URL, questions: K.quiz12)
        ],
        K.unit2: [
            Topic(id: 3, name: K.topic21, articleURL: K.article21URL, questions: K.quiz21),
            Topic(id: 4, name: K.topic22, articleURL: K.article22URL, questions: K.quiz22),
            Topic(id: 5, name: K.topic23, articleURL: K.article23URL, questions: K.quiz23),
            Topic(id: 6, name: K.topic24, articleURL: K.article24URL, questions: K.quiz24)
        ]
        // Add more units here
    ]

    var body: some View {
        var progress: Int = UserDefaults.standard.integer(forKey: "userprogress")
        
        VStack {
            
            Text("Units \(progress)")
                .font(.largeTitle)
                .padding(.all)
            
            List {
                if let topics = unitview[K.unit1] {
                    ForEach(topics.prefix(progress), id: \.id) { topic in
                        NavigationLink(destination: TopicDetailView(topic: topic)) {
                            Text(topic.name)
                        }
                    }
                }
                
            }
            
//            List {
//                ForEach(units.keys.sorted(), id: \.self) { unit in
//                    Section(header: Text(unit)) {
//                        ForEach(units[unit]!, id: \.id) { topic in
//                            NavigationLink(destination: TopicDetailView(topic: topic)) {
//                                Text(topic.name)
//                            }
//                        }
//                    }
//                }
//            }
            .listStyle(GroupedListStyle())
            .navigationBarHidden(true) // Hide the navigation bar
            .navigationBarBackButtonHidden(true)
        }
    }
}



struct UnitsView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsView()
    }
}
