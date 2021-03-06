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

    var startingDuration = 5
    var seconds = 0
    var timer = Timer()
    var timerIsRunning = false
    var resumeClicked = false
    
    
    
    @IBAction func startButtonClicked(_ sender: Any) {
        if timerIsRunning == false {
            seconds = startingDuration
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
        seconds = startingDuration
        timerLabel.stringValue = timeString(time: TimeInterval(seconds))
        timerIsRunning = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: (#selector(ViewController.updateTimer)),
                                     userInfo: nil, repeats: true)
        timerIsRunning = true
    }
    @objc
    func updateTimer() {
        if seconds < 1 {
            notifyCompletion()
            timer.invalidate()
        } else {
            seconds -= 1
            timerLabel.stringValue = timeString(time: TimeInterval(seconds))
        }
    }
    
    func notifyCompletion() {
        // alert
        let notification = NSUserNotification()
        notification.identifier = "unique-id"
        notification.title = "Timer Complete!"
        notification.subtitle = "How did you do?"
        notification.informativeText = "This is a test"
        notification.soundName = NSUserNotificationDefaultSoundName
        // notification.contentImage = NSImage(contentsOf: URL(string: "https://placehold.it/300")!)
        // Manually display the notification
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
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
        timerLabel.stringValue = timeString(time: TimeInterval(startingDuration))
        // Do any additional setup after loading the view.
    }
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

