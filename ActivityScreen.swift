//
//  ActivityScreen.swift
//  Lab8.1
//
//  Created by Larsen, Lauren M on 12/8/19.
//  Copyright © 2019 Larsen, Lauren M. All rights reserved.
//

import UIKit
import SQLite3

class ActivityScreen: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    let ACTIVITYCELL: String = "ActivityCell"
    let color: UIColor = UIColor()
    let dirPath: String = "\(NSHomeDirectory())/tmp"
    let filePath: String = "\(NSHomeDirectory())/tmp/activity.txt"
    
    let nameTextField: UITextField = UITextField()
    let activityTextField: UITextField = UITextField()
    let startTextField: UITextField = UITextField()
    let endTextField: UITextField = UITextField()
    
    var mvc: MainScreen = MainScreen()
    let activityTableView: UIScrollView = UIScrollView()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemIndigo
        
      
        
        let returnButton = UIButton(type: UIButton.ButtonType.custom)
            returnButton.frame = CGRect(x: view.center.x-100, y: 825, width: 200, height: 50)
            returnButton.setTitle("Return to Main Screen", for: UIControl.State.normal)
            returnButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            returnButton.backgroundColor = UIColor.yellow
            returnButton.addTarget(self, action: #selector(ActivityScreen.returnHandleTap), for: UIControl.Event.touchUpInside)
                   
            view.addSubview(returnButton)
        
        nameTextField.frame = CGRect(x: view.center.x-135, y: 50, width: 300, height: 50)
        nameTextField.textColor = UIColor.black
        nameTextField.font = UIFont.systemFont(ofSize: 24.0)
        nameTextField.placeholder = "<Activity Name>"
        nameTextField.backgroundColor = UIColor.white
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextField.ViewMode.always
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.borderStyle = UITextField.BorderStyle.line
        nameTextField.layer.borderWidth = 1
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        activityTextField.frame = CGRect(x: view.center.x-135, y: 125, width: 300, height: 50)
        activityTextField.textColor = UIColor.black
        activityTextField.font = UIFont.systemFont(ofSize: 24.0)
        activityTextField.placeholder = "<Activity Description>"
        activityTextField.backgroundColor = UIColor.white
        activityTextField.keyboardType = UIKeyboardType.default
        activityTextField.returnKeyType = UIReturnKeyType.done
        activityTextField.clearButtonMode = UITextField.ViewMode.always
        activityTextField.borderStyle = UITextField.BorderStyle.line
        activityTextField.layer.borderColor = UIColor.black.cgColor
        activityTextField.layer.borderWidth = 1
        activityTextField.delegate = self
        view.addSubview(activityTextField)
        
        startTextField.frame = CGRect(x: view.center.x-135, y: 200, width: 300, height: 50)
        startTextField.textColor = UIColor.black
        startTextField.font = UIFont.systemFont(ofSize: 24.0)
        startTextField.placeholder = "<Start Time>"
        startTextField.backgroundColor = UIColor.white
        startTextField.keyboardType = UIKeyboardType.default
        startTextField.returnKeyType = UIReturnKeyType.done
        startTextField.clearButtonMode = UITextField.ViewMode.always
        startTextField.borderStyle = UITextField.BorderStyle.line
        startTextField.layer.borderColor = UIColor.black.cgColor
        startTextField.layer.borderWidth = 1
        startTextField.delegate = self
        
        let datePickerView1: UIDatePicker = UIDatePicker()
        startTextField.inputView = datePickerView1
        datePickerView1.timeZone = NSTimeZone.local
        datePickerView1.datePickerMode = UIDatePicker.Mode.time
        datePickerView1.addTarget (self, action: #selector (self.handleDatePickerStart), for: UIControl.Event.valueChanged)
        view.addSubview(startTextField)
        
        endTextField.frame = CGRect(x: view.center.x-135, y: 275, width: 300, height: 50)
        endTextField.textColor = UIColor.black
        endTextField.font = UIFont.systemFont(ofSize: 24.0)
        endTextField.placeholder = "<End Time>"
        endTextField.backgroundColor = UIColor.white
        endTextField.keyboardType = UIKeyboardType.default
        endTextField.returnKeyType = UIReturnKeyType.done
        endTextField.clearButtonMode = UITextField.ViewMode.always
        endTextField.borderStyle = UITextField.BorderStyle.line
        endTextField.layer.borderColor = UIColor.black.cgColor
        endTextField.layer.borderWidth = 1
        endTextField.delegate = self
        
        let datePickerView2: UIDatePicker = UIDatePicker()
        endTextField.inputView = datePickerView2
        datePickerView2.timeZone = NSTimeZone.local
        datePickerView2.datePickerMode = UIDatePicker.Mode.time
        datePickerView2.addTarget (self, action: #selector (self.handleDatePickerEnd), for: UIControl.Event.valueChanged)
        view.addSubview(endTextField)
        
 
                
        var button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 5, y: 350, width: 200, height: 50)
        button.setTitle("Add Activity", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor.magenta
        button.addTarget(self, action: #selector(ActivityScreen.addActivity), for: UIControl.Event.touchUpInside)
//        button.addTarget(self, action: #selector(MainScreen.addActivity), for: UIControl.Event.touchUpInside)
        view.addSubview(button)

        
        button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 210, y: 350, width: 200, height: 50)
        button.setTitle("Clear Activities", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor.magenta
        button.addTarget(self, action: #selector(ActivityScreen.clearRecords), for: UIControl.Event.touchUpInside)
        view.addSubview(button)
//        button.addTarget(self, action: #selector(SettingsScreen.clearRecordsSet), for: UIControl.Event.touchUpInside)
//                         view.addSubview(button)

        let label: UILabel = UILabel(frame: CGRect(x: view.center.x-100, y: 400, width: 200, height: 50))
        label.text = "Activity Table"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        
        
        
        activityTableView.frame = CGRect(x: view.center.x-150, y: 450, width: 300, height: 350)
        //activityTableView.dataSource = self as? UITableViewDataSource
        activityTableView.delegate = self
        activityTableView.backgroundColor = UIColor.white
        view.addSubview(activityTableView)
        
//        createDirectory()
//        restoreFromFile()
      
             
        
        // Swipe right to dismiss to return to the control view controller
        view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action:
            #selector(MainScreen.dismissViewController(_:))))
    
   
    }
      @objc func addActivity () {
        let vc : MainScreen =   presentingViewController as! MainScreen
        vc.activityList.append(Activity(name: nameTextField.text!, desc: activityTextField.text!, start: startTextField.text!, end: endTextField.text!))
        vc.saveToFile()
        vc.restoreFromFile()
        vc.activityTableView.reloadData()

        nameTextField.text?.removeAll()
       activityTextField.text!.removeAll()
        endTextField.text?.removeAll()
        self.dismiss(animated: true) {
            self.mvc.viewDidLoad()
        }
    }
    @objc func clearRecords(){
         
             let Main : MainScreen =  presentingViewController as! MainScreen
             Main.clearActivity()
             Main.deleteFile()
             Main.activityTableView.reloadData()
    }
    
          @objc func backgroundColorChange(Activitycolor: UIColor) {
            print("Changing Activity Screen Background Color()")
          self.view.backgroundColor = Activitycolor
              
}
    //return to the main screen
     @objc func returnHandleTap(){
         presentingViewController?.dismiss(animated: true, completion: {() -> Void in
             print("ViewController dismissed...")
         })
     }
    
    private func displayDirectory() {
        print("Absolute path for Home Directory: \(NSHomeDirectory())")
        if let dirEnumerator = FileManager.default.enumerator(atPath: NSHomeDirectory()) {
            while let currentPath = dirEnumerator.nextObject() as? String {
                print(currentPath)
            }
        }
    }
    
    private func createDirectory() {
        print("Before directory is created...")
        displayDirectory()
        var isDir: ObjCBool = true
        if FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) {
            if isDir.boolValue {
                print("\(dirPath) exists and is a directory")
            }
            else {
                print("\(dirPath) exists and is not a directory")
            }
        }
        else {
            print("\(dirPath) does not exist")
            do {
                try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("Error creating directory \(dirPath): \(error)")
            }
        }
        print("After directory is created...")
        displayDirectory()
    }
    

    @objc func handleDatePickerStart(sender: UIDatePicker){
        let dateFormatter1 = DateFormatter()
       dateFormatter1.dateFormat = "MM/dd/yyyy hh:mm a"
        startTextField.text = dateFormatter1.string(from: sender.date)
    }
    
    @objc func handleDatePickerEnd(sender: UIDatePicker){
          let dateFormatter2 = DateFormatter()
          dateFormatter2.dateFormat = "MM/dd/yyyy hh:mm a"
          endTextField.text = dateFormatter2.string(from: sender.date)
      }
      
        
    
    }
 












