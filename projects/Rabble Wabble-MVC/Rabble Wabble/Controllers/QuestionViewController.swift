//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/27/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import UIKit

public class QuestionViewController: UIViewController {
    public var questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    public var questionView: QuestionView! {
        guard isViewLoaded else {return nil}
        guard let view = view as? QuestionView else {return nil}
        return view
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()

    }
    private func showQuestion() {
        //THE CONTROLLER SPEAKS WITH THE DATA MODEL
        let question = questionGroup.questions[questionIndex]
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
    }

    @IBAction func toggleAnswerLabels(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
            self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
        }
    }
    @IBAction func handleCorret(_ sender: Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    @IBAction func handleIncorret(_ sender: Any) {
         incorrectCount += 1
         questionView.incorrectCountLabel.text = "\(incorrectCount)"
         showNextQuestion()
     }
    private func showNextQuestion() {
        questionIndex += 1
        //THE INDEX IS GREATER THAN THE NUMBER OF QUESTIONS
        guard questionIndex < questionGroup.questions.count else {
            
            return
        }
        showQuestion()
    }
}
