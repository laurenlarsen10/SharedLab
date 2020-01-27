//
//  PreviewController.swift
//  Lab8.1
//
//  Created by Larsen, Lauren M on 12/8/19.
//  Copyright © 2019 Larsen, Lauren M. All rights reserved.
//

import UIKit
let topics: [(String,String)] = [("Main Screen",NSStringFromClass(MainScreen.self)),
                            ("New Activity",NSStringFromClass(ActivityScreen.self)),
                            ("Settings",NSStringFromClass(SettingsScreen.self)),
             ]

class PreviewController: UITableViewController {
    
    init() {
        super.init(style: UITableView.Style.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // UITableViewDataSource
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return topics.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       // let cell = tableView.dequeueReusableCell(withIdentifier: COURSETYPECELL) ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: COURSETYPECELL)
//        let courseEntry = UITextView(frame: CGRect(x: 0.125*tableView.frame.width, y: 0, width: 0.75*tableView.frame.width, height: 50))
//        courseEntry.tag = 1
//        if indexPath.row % 2 == 0 {
//            courseEntry.backgroundColor = UIColor.systemIndigo
//        }
//        else {
//            courseEntry.backgroundColor = UIColor.systemIndigo
//        }
//        courseEntry.font = UIFont.boldSystemFont(ofSize: 18.0)
//        cell.contentView.addSubview(courseEntry)
//        let (A,_) = topics[indexPath.row]
//        courseEntry.text = A
//        courseEntry.isUserInteractionEnabled = false
//        return cell
//    }
//
//    // UITableViewDelegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let (_,A) = topics[indexPath.row]
//        // The following dynamically creates an object from a string
//        if let classType = NSClassFromString(A) as? UIViewController.Type {
//            tableView.deselectRow(at: indexPath, animated: false)
//            let vc: UIViewController = classType.init()
//            vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
//            present(vc, animated: true, completion: {() -> Void in
//            })
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 60
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 36))
//        label.backgroundColor = UIColor.systemGray4
//        label.text = "Activity Tracker"
//        label.textAlignment = NSTextAlignment.center
//        label.font = UIFont.boldSystemFont(ofSize: 36.0)
//        return label
//    }
//
//}
}
