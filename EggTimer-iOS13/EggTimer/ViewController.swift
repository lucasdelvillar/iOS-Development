//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    //    using a dictionary instead of variables
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

//    Function isn't needed because we are only playing one sounds. Just use the code.
//    func playSound(soundName: String) {
//        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
//        player = try! AVAudioPlayer(contentsOf: url!)
//        player.play()
        
//    }
    
//    Starts a countdown
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            // immedialy goes to the 1st percentage rather than starting at 0.
            secondsPassed += 1
           //must convert ints to floats seperatly before dividing otherwise we take the floor and it return 0
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate() // don't know why I need this
            titleLabel.text = "Done!" //change label to done
//            playSound(soundName: "alarm_sound")
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            }
        
        }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        //this activates the updateCounter function
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }

}
