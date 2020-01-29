//
//  RandomQuestionsStrategy.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/28/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionsStrategy: QuestionStrategy {
    public var title: String {
        return questionGroup.title
    }
    public var correctCount: Int = 0
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        guard let questions = GKRandomSource.sharedRandom()
            .arrayByShufflingObjects(in: questionGroup.questions) as? [Question] else {self.questions = [];return}
        self.questions = questions
    }
    public var incorrectCount: Int = 0
    public func advanceTonextQuestion() -> Bool {
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    public func currentQuestion() -> Question {
        questions[questionIndex]
    }
    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    public func markQuestionInCorrect(_ question: Question) {
        incorrectCount -= 1
    }
    public func questionIndexTitle() -> String {
        "\(questionIndex + 1)/" + "\(questions.count)"
    }
}
