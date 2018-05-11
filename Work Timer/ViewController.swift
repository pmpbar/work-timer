//
//  ViewController.swift
//  Work Timer
//
//  Created by taylor on 5/10/18.
//  Copyright © 2018 taylor. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {


    @IBOutlet weak var timerLabel: NSTextField!
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var timerIsRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeClicked = false
    
    
    
    @IBAction func startButtonClicked(_ sender: Any) {
        if timerIsRunning == false {
            runTimer()
        }
    }
    @IBAction func pauseButtonClicked(_ sender: Any) {
        if self.resumeClicked == false {
            timer.invalidate()
            self.resumeClicked = true
        } else {
            runTimer()
            self.resumeClicked = false
        }
    }

    @IBAction func resetButtonClicked(_ sender: Any) {
        timer.invalidate()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.stringValue = timeString(time: TimeInterval(seconds))
        timerIsRunning = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsRunning = true
    }
    @objc
    func updateTimer() {
        if seconds < 1 {
         // alert
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timerLabel.stringValue = timeString(time: TimeInterval(seconds)) //This will update the label.
        }
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    /* @IBAction func sayButtonClicked(_ sender: Any) {
        var name = nameField.stringValue
        if name.isEmpty {
            name = "World"
        }
        let greeting = "Hello \(name)!"
        helloLabel.stringValue = greeting
    } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

