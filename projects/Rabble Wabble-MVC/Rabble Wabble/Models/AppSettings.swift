//
//  AppSettings.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/29/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation
public class AppSettings {
    public static let shared = AppSettings()
    private init() {}
    public func questionStrategy( for questionGroup: QuestionGroup) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroup)
    }
    private let userDefaults = UserDefaults.standard
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
}

public enum QuestionStrategyType: Int, CaseIterable {
    case random
    case sequantial
    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequantial:
            return "Sequantial"
        }
    }
    public func questionStrategy(
        for questionGroup: QuestionGroup) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionsStrategy(questionGroup: questionGroup)
        case .sequantial:
            return SequentialQuestionStrategy(questionGroup: questionGroup)
        }
    }
}
