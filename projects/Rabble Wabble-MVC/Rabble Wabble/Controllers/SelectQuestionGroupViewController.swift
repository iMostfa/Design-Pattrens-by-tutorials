//
//  SelectQuestionGroupViewController.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/27/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation
import UIKit
public class SelectQuestionGroupViewController: UIViewController {
    // MARK: OUTLETS
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    // MARK: Properties
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
}
extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionGroups.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell", for: indexPath)
            as? QuestionGroupCell else {return UITableViewCell()}
        cell.titleLabel.text = questionGroups[indexPath.row].title
        return cell
    }

}
extension SelectQuestionGroupViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else {return}
        viewController.questionStrategy = AppSettings.shared.questionStrategy(for: selectedQuestionGroup)
        viewController.delegate = self
    }

}

extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: QuestionViewController,
                                       didCancel: QuestionStrategy, at questionIndex: Int) {navigationController?.popViewController(animated: true)}
    public func questionViewController(_ viewController: QuestionViewController, didComplete: QuestionStrategy) {
                navigationController?.popViewController(animated: true)

    }

}
