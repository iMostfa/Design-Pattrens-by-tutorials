//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/27/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import UIKit

public protocol QuestionViewControllerDelegate: class {
    func questionViewController( _ viewController: QuestionViewController,
                                 didCancel: QuestionStrategy, at questionIndex: Int)
    func questionViewController( _ viewController: QuestionViewController, didComplete: QuestionStrategy)
}

public class QuestionViewController: UIViewController {
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
    public weak var delegate: QuestionViewControllerDelegate?
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    public var questionView: QuestionView! {
        guard isViewLoaded else {return nil}
        guard let view = view as? QuestionView else {return nil}
        return view
    }
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil )
        item.tintColor = .systemOrange
        self.navigationItem.rightBarButtonItem = item
        return item
    }()
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()

    }
    private func showQuestion() {
        //THE CONTROLLER SPEAKS WITH THE DATA MODEL
        let question = questionStrategy.currentQuestion()
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = #imageLiteral(resourceName: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: nil,
                                                           style: .plain, target: self, action: action)
    }
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy, at: questionIndex)
    }

    @IBAction func toggleAnswerLabels(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.questionView.answerLabel.isHidden = !self.questionView.answerLabel.isHidden
            self.questionView.hintLabel.isHidden = !self.questionView.hintLabel.isHidden
        }
    }
    @IBAction func handleCorret(_ sender: Any) {
        questionStrategy.markQuestionCorrect(questionStrategy.currentQuestion())
        questionView.correctCountLabel.text = "\(questionStrategy.correctCount)"
        showNextQuestion()
    }
    @IBAction func handleIncorret(_ sender: Any) {
         questionStrategy.markQuestionInCorrect(questionStrategy.currentQuestion())
        questionView.incorrectCountLabel.text = "\(questionStrategy.incorrectCount)"
         showNextQuestion()
     }
    private func showNextQuestion() {
        questionIndex += 1
        //THE INDEX IS GREATER THAN THE NUMBER OF QUESTIONS => complete
        guard questionStrategy.advanceTonextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
}
