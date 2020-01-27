//
//  Settings.swift
//  Lab8.1
//
//  Created by Larsen, Lauren M on 12/8/19.
//  Copyright © 2019 Larsen, Lauren M. All rights reserved.
//

import UIKit

class SettingsScreen: UIViewController, UITextFieldDelegate {
    private var startingPoint: CGPoint = CGPoint(x: 0, y: 0)
 
    let nameTextField: UITextField = UITextField()
    let ageTextField: UITextField = UITextField()
   let label: UILabel = UILabel(frame: CGRect(x: 10, y: 50, width: 400, height: 50))
   let label1: UILabel = UILabel(frame: CGRect(x: 10, y: 350, width: 400, height: 50))
     let mainBlueButton = UIButton(type: UIButton.ButtonType.custom)
     let ActBlueButton = UIButton(type: UIButton.ButtonType.custom)
     let mainGreenButton = UIButton(type: UIButton.ButtonType.custom)
     let ActGreenButton = UIButton(type: UIButton.ButtonType.custom)
     let mainRedButton = UIButton(type: UIButton.ButtonType.custom)
    let ActRedButton = UIButton(type: UIButton.ButtonType.custom)
    let returnButton = UIButton(type: UIButton.ButtonType.custom)
    let returnButton1 = UIButton(type: UIButton.ButtonType.custom)
    let buttons = UIButton(type: UIButton.ButtonType.custom)
  var mvc: MainScreen = MainScreen()
    var act: ActivityScreen = ActivityScreen()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.systemTeal
      

            
            
                           returnButton.frame = CGRect(x: view.center.x-100, y: 800, width: 200, height: 50)
                           returnButton.setTitle("Return to Main Screen", for: UIControl.State.normal)
                           returnButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                          returnButton.backgroundColor = UIColor.yellow
                  returnButton.addTarget(self, action: #selector(SettingsScreen.returnHandleTap), for: UIControl.Event.touchUpInside)
            
                           view.addSubview(returnButton)
            
//            returnButton1.frame = CGRect(x: view.center.x-100, y: 750, width: 250, height: 50)
//                           returnButton1.setTitle("Return to Activity Screen", for: UIControl.State.normal)
//                           returnButton1.setTitleColor(UIColor.black, for: UIControl.State.normal)
//                          returnButton1.backgroundColor = UIColor.yellow
//                  returnButton1.addTarget(self, action: #selector(SettingsScreen.returnHandleTap), for: UIControl.Event.touchUpInside)
//
//                           view.addSubview(returnButton1)
//
             label.text = "Change Main Screen Background"
             label.textColor = UIColor.black
             label.font = UIFont.systemFont(ofSize: 24.0)
             label.textAlignment = NSTextAlignment.center
             label.backgroundColor = UIColor.systemIndigo
             view.addSubview(label)

           
            label1.text = "Change Activity Screen Background"
            label1.textColor = UIColor.black
            label1.font = UIFont.systemFont(ofSize: 24.0)
            label1.textAlignment = NSTextAlignment.center
            label1.backgroundColor = UIColor.systemIndigo
            view.addSubview(label1)
            
      
       mainBlueButton.frame = CGRect(x: 100, y: 220, width: 200, height: 50)
       mainBlueButton.setTitle("Red", for: UIControl.State.normal)
       mainBlueButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
       mainBlueButton.backgroundColor = UIColor.white
        mainBlueButton.tag = 1
        mainBlueButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
               view.addSubview(mainBlueButton)
            
            mainGreenButton.frame = CGRect(x: 100, y: 160, width: 200, height: 50)
                         mainGreenButton.setTitle("Green", for: UIControl.State.normal)
                         mainGreenButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                          mainGreenButton.backgroundColor = UIColor.white
                                  mainGreenButton.tag = 2
                                  mainGreenButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                                         view.addSubview(mainGreenButton)
            
            
            mainRedButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
             mainRedButton.setTitle("Blue", for: UIControl.State.normal)
            mainRedButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            mainRedButton.backgroundColor = UIColor.white
                      mainRedButton.tag = 3
                      mainRedButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                             view.addSubview(mainRedButton)
            
            buttons.frame = CGRect(x: 100, y: 280, width: 200, height: 50)
            buttons.setTitle("Button Colors", for: UIControl.State.normal)
                    buttons.setTitleColor(UIColor.black, for: UIControl.State.normal)
                     buttons.backgroundColor = UIColor.white
                      buttons.tag = 7
                      buttons.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                          view.addSubview(buttons)
                       
            
            
                 ActBlueButton.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
                 ActBlueButton.setTitle("Blue", for: UIControl.State.normal)
                 ActBlueButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                 ActBlueButton.backgroundColor = UIColor.white
                  ActBlueButton.tag = 4
                  ActBlueButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                         view.addSubview(ActBlueButton)
              
          
            
                ActGreenButton.frame = CGRect(x: 100, y: 460, width: 200, height: 50)
                         ActGreenButton.setTitle("Green", for: UIControl.State.normal)
                         ActGreenButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                          ActGreenButton.backgroundColor = UIColor.white
                        ActGreenButton.tag = 5
                        ActGreenButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                            view.addSubview(ActGreenButton)
            
           
                  
           
                ActRedButton.frame = CGRect(x: 100, y: 520, width: 200, height: 50)
                ActRedButton.setTitle("Red", for: UIControl.State.normal)
                ActRedButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                 ActRedButton.backgroundColor = UIColor.white
                ActRedButton.tag = 6
                ActRedButton.addTarget(self, action: #selector(SettingsScreen.changeColors), for: UIControl.Event.touchUpInside)
                    view.addSubview(ActRedButton)
            
           
            
            
            var clearButton = UIButton(type: UIButton.ButtonType.custom)
                   clearButton = UIButton(type: UIButton.ButtonType.custom)
                   clearButton.frame = CGRect(x: view.center.x-100, y: 700, width: 200, height: 50)
                   clearButton.setTitle("Clear Activities", for: UIControl.State.normal)
                   clearButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                   clearButton.backgroundColor = UIColor.systemYellow
                 clearButton.addTarget(self, action: #selector(SettingsScreen.clearRecordsSet), for: UIControl.Event.touchUpInside)
                   view.addSubview(clearButton)
                  
            
    }
    
    @objc func returnHandleTap(){
        presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            print("ViewController dismissed...")
        })
    }
    
    @objc func clearRecordsSet(){
           
          let Main : MainScreen =  presentingViewController as! MainScreen
                   Main.clearActivity()
      
    }
    
  
   @objc func changeColors(sender:UIButton){
             let MainColor : MainScreen =  presentingViewController as! MainScreen
            let Activitycolor : ActivityScreen = ActivityScreen()
    
             if(sender.tag == 1){
                MainColor.backgroundColorChanger(backColor: UIColor.red)
             }
             if(sender.tag == 2){
                MainColor.backgroundColorChanger(backColor: UIColor.green)
             }
             if(sender.tag == 3){
                MainColor.backgroundColorChanger(backColor: UIColor.blue)

            if(sender.tag == 4){
                Activitycolor.backgroundColorChange(Activitycolor: UIColor.blue)
                }
                if(sender.tag == 5){
                    Activitycolor.backgroundColorChange(Activitycolor: UIColor.green)
                }
                if(sender.tag == 6){
               Activitycolor.backgroundColorChange(Activitycolor: UIColor.red)
                }
                if(sender.tag == 7){
                MainColor.buttonColorChange(buttonColor: UIColor.systemTeal)
                 }
              
         }
     
    }

}


