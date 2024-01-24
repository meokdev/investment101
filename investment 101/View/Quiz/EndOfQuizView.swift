//
//  EndOfQuizView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI

struct EndOfQuizView: View {
    let questions: [Question]
    let userAnswers: [String]
    let nextTopicID: Int
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = QuizViewModel()

    @State private var isCheckingAnswers = false
    @State private var shouldNavigateToMainMenu = false // New state for navigation

    var score: Double {
        let rightAnswer = zip(questions, userAnswers).filter { $0.0.rightAnswer == $0.1 }
        let percentage = Double(rightAnswer.count) / Double(questions.count) * 100
        return percentage
    }

    var resultMessage: String {
        if score >= 80 {
            return "Amazing! Good work!"
        } else if score >= 50 {
            return "Great job!"
        } else if score >= 20 {
            return "Keep practicing!"
        } else {
            return "It's okay. Try again!"
        }
    }

    var body: some View {
        VStack {
            Text(resultMessage)
                .font(.title)
                .padding()

            Text("Your Score: \(score, specifier: "%.0f")%")
                .font(.headline)
                .padding()

            Text("XP: \(UserDefaults.xpPoints)")

            Spacer()

            Button(action: {
                isCheckingAnswers = true // Set the flag to show the CheckAnswersView
                
            }) {
                Text("Check Answers")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.vertical, -5)

            // Use NavigationLink conditionally based on shouldNavigateToMainMenu
            NavigationLink(destination: MainMenuView(), isActive: $shouldNavigateToMainMenu) {
                EmptyView()
            }
            .hidden() // Hide the link

            Button(action: {
                shouldNavigateToMainMenu = true
                if score > 65 {
                    viewModel.updateUnlockedTopicIDs(nextTopicID)
                }
                // Activate the NavigationLink
            }) {
                Text("Return Home")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .frame(height: 70)
            }
            .padding(.bottom, 5)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: EmptyView())
        .sheet(isPresented: $isCheckingAnswers) {
            CheckAnswersView(questions: questions, userAnswers: userAnswers)
        }
    }
}



struct CheckAnswersView: View {
    let questions: [Question]
    let userAnswers: [String]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(questions, id: \.self) { question in
                    let index = questions.firstIndex(of: question) ?? 0
                    let userAnswer = userAnswers[index]
                    let isCorrect = question.rightAnswer == userAnswer

                    HStack {
                        Text("Q\(index + 1): \(question.text)")
                            .font(.headline)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(isCorrect ? .green : .red)

                        Text("Answer: \(question.rightAnswer)")
                            .font(.subheadline)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(isCorrect ? .green : .red)
                    }
                    .padding()
                }
            }
        }
    }
}



