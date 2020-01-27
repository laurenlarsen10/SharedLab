//
//  ViewController.swift
//  Lab8.1
//
//  Created by Larsen, Lauren M on 12/8/19.
//  Copyright © 2019 Larsen, Lauren M. All rights reserved.
//

import UIKit
import SQLite3

class MainScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {


        let ACTIVITYCELL: String = "ActivityCell"
        
        let dirPath: String = "\(NSHomeDirectory())/tmp"
        let filePath: String = "\(NSHomeDirectory())/tmp/activity.txt"
   
        
        
        let activityTableView: UITableView = UITableView()
        var db: OpaquePointer? //used for DB functions
         var activityList = [Activity]()
       let label1: UILabel = UILabel()
   // let label2: UILabel = UILabel()
    let button = UIButton(type: UIButton.ButtonType.custom)
    let button1 = UIButton(type: UIButton.ButtonType.custom)
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.systemIndigo

      
            //This is the table display
            activityTableView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: view.bounds.height)
                   activityTableView.dataSource = self
                   activityTableView.delegate = self
                   activityTableView.backgroundColor = UIColor.white
                   view.addSubview(activityTableView)
                   activityTableView.reloadData()
            
            //button to go to the ActivityScreen
            //let button = UIButton(type: UIButton.ButtonType.custom)
            button.frame = CGRect(x: 5, y: 120, width: 200, height: 50)
            button.setTitle("Add to Activity List", for: UIControl.State.normal)
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.backgroundColor = UIColor.magenta
            button.addTarget(self, action: #selector(MainScreen.activityHandleTap(_:)), for: UIControl.Event.touchUpInside)
            view.addSubview(button)
            
            label1.text = "Update Settings"
            label1.backgroundColor = UIColor.magenta
            label1.textColor = UIColor.black
            label1.textAlignment = NSTextAlignment.center
            label1.frame = CGRect(x: 210, y: 120, width: 195, height: 50)
            label1.isUserInteractionEnabled = true
            label1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MainScreen.handleTap(_:))))
                view.addSubview(label1)
            button1.frame = CGRect(x: 100, y: 800, width: 200, height: 50)
            button1.setTitle("Delete Entries", for: UIControl.State.normal)
            button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button1.backgroundColor = UIColor.yellow
            button1.addTarget(self, action: #selector(MainScreen.activityHandleTap(_:)), for: UIControl.Event.touchUpInside)
            view.addSubview(button1)
            
            //Label to name the activity table
            let label: UILabel = UILabel(frame: CGRect(x: 100, y: 60, width: 195, height: 50))
            label.text = "Activity Table"
            label.textColor = UIColor.black
            label.font = UIFont.systemFont(ofSize: 30.0)
            label.textAlignment = NSTextAlignment.center
            label.backgroundColor = UIColor.clear
            view.addSubview(label)

      
               
                 
           
            // Swipe right to dismiss to return to the control view controller
            view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(MainScreen.dismissViewController(_:))))
            
            
            restoreFromFile()
            activityTableView.reloadData()
            
        }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
               let vc: SettingsScreen = SettingsScreen()
               vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
               vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               present(vc, animated: true, completion: {
                                () -> Void in
                                vc.viewDidLoad()
               })
         
       }
    @objc func backgroundColorChanger(backColor: UIColor) {
         print("Changing MainScreen Background Color()")
          view.backgroundColor = backColor
       
    }

  
    @objc func activityHandleTap(_ recognizer: UITapGestureRecognizer) {
                  let avc: ActivityScreen = ActivityScreen()//vc is instance
                  avc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                  avc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                  present(avc, animated: true, completion: {//if false its instant
                                   () -> Void in
                                   avc.viewDidLoad()
                  })
            
        
       
    }
    @objc func buttonColorChange(buttonColor: UIColor) {
          print("Changing Button Colors()")
        button.backgroundColor = buttonColor
        button1.backgroundColor = buttonColor
        label1.backgroundColor = buttonColor
    }
        
        // Return to previous view controller when user swipes right
        @objc func dismissViewController(_ recognizer: UISwipeGestureRecognizer) {
           
            presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            })
        }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return activityList.count
        }
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ACTIVITYCELL) ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: ACTIVITYCELL)
            let activity: Activity
            activity = activityList[indexPath.row]
            cell.textLabel?.text = "My activity was \(activity.name!) which is \(activity.desc!) from \(activity.start!) til \(activity.end!)"
        
            return cell
        }
   
 
         func displayDirectory() {
            print("Absolute path for Home Directory: \(NSHomeDirectory())")
            if let dirEnumerator = FileManager.default.enumerator(atPath: NSHomeDirectory()) {
                while let currentPath = dirEnumerator.nextObject() as? String {
                    print(currentPath)
                }
            }
        }
        
         func createDirectory() {
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
        
        func saveToFile() {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: activityList, requiringSecureCoding: false)
                if FileManager.default.createFile(atPath: filePath,
                                          contents: data,
                                          attributes: nil) {
                    print("File \(filePath) successfully created")
                }
                else {
                    print("File \(filePath) could not be created")
                }
                restoreFromFile()
                activityTableView.reloadData()
            }
            catch {
                print("Error archiving data: \(error)")
            }
        }
        
         func restoreFromFile() {
             do {
                 if let data = FileManager.default.contents(atPath: filePath) {
                     print("Retrieving data from file (filePath)")
                     activityList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Activity] ?? [Activity]()
                     activityTableView.reloadData()
                 }
                 else {
                     print("No data available in file (filePath)")
                     activityList = [Activity]()
                 }
             }
             catch {
                 print("Error unarchiving data: (error)")
             }
             activityTableView.reloadData()
         }
        
         func deleteFile() {
            do {
                try FileManager.default.removeItem(atPath: filePath)
            }
            catch {
                print("Error deleting file: \(error)")
            }
        }
    
    @objc func clearActivity() {
        activityList.removeAll()
    
        deleteFile()
        
        activityTableView.reloadData()
    }
    
          
}
        

    class Activity: NSObject, NSCoding{
         var activityName: String = String()
         var activityDescription: String = String()
        var startDate: String = String()
         var endDate: String = String()
     
    
                 let TNNAME: String = "Activity Name"
                 let TNDESCRIPTION: String = "Activity Description"
                 let TNSTART: String = "Start Time"
                 let TNEND: String = "End Time"
                 
                 let name: String?
                 var desc: String?
                 var start: String?
                 var end: String?
                 
        init(name: String, desc: String?, start: String?, end: String?){
                     self.name = name
                     self.desc = desc
                     self.start = start
                     self.end = end
                 }
                 
                 required init(coder aDecoder: NSCoder) {
                     name = aDecoder.decodeObject(forKey: TNNAME) as? String
                     desc = aDecoder.decodeObject(forKey: TNDESCRIPTION) as? String
                     start = aDecoder.decodeObject(forKey: TNSTART) as? String
                     end = aDecoder.decodeObject(forKey: TNEND) as? String
                 }
                 
                 func encode(with aCoder: NSCoder) {
                     aCoder.encode(name, forKey: TNNAME)
                     aCoder.encode(desc, forKey: TNDESCRIPTION)
                     aCoder.encode(start, forKey: TNSTART)
                    aCoder.encode(end, forKey: TNEND)
                 }
         
 }
 
      
