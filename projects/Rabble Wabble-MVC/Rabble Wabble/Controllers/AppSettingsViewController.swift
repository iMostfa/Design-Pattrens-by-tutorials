//
//  AppSettingsViewController.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/29/20.
//  Copyright © 2020 mostfa. All rights reserved.
//
// swiftlint:disable all


import UIKit

public class AppSettingsViewController: UITableViewController {
    public let appSettings = AppSettings.shared
    private let cellID = "basicCell"
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
      //  tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        //to make sure that the type of your class is UITABLEVIEWCELL
    }
}
extension AppSettingsViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        QuestionStrategyType.allCases.count
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        let questionType = QuestionStrategyType.allCases[indexPath.row]
        cell.textLabel!.text = questionType.title()
        if appSettings.questionStrategyType == questionType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    return cell
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionType
        tableView.reloadData()
    }
}
