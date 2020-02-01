//
//  QuestionGroup.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/27/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    public class Score: Codable {
        public var correctCount: Int = 0
        public var inCorrectCount: Int = 0
        public init() {}
    }
    public let questions: [Question]
    public let title: String
    public var score: Score
    public init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }

}
