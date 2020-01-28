//
//  QuestionStrategy.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/28/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: class {
    var title: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int {get}
    
    func advanceTonextQuestion() -> Bool
    func currentQuestion() -> Question
    func markQuestionCorrect(_ question: Question)
    func markQuestionInCorrect(_ question:Question)
    func questionIndexTitle() -> String
}
