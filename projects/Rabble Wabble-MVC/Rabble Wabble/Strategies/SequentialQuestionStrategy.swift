//
//  SequentialQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/28/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: QuestionStrategy {
    public var title: String {
        questionGroup.title
    }
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    public func advanceTonextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    public func currentQuestion() -> Question {
        questionGroup.questions[questionIndex]
    }
    public func markQuestionCorrect(_ question: Question) {
        correctCount+=1
    }
    public func markQuestionInCorrect(_ question: Question) {
        incorrectCount-=1
    }
    public func questionIndexTitle() -> String {
        "\(questionIndex + 1)/" + "\(questionGroup.questions.count)"
    }
}
