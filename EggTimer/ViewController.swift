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
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var totalTime = 0
    var secondPassed = 0
    
    var timer = Timer()
    
    var player: AVAudioPlayer!

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
     }

     @objc func updateCounter() {
         if secondPassed < totalTime {
             secondPassed += 1
             progressBar.progress = Float(secondPassed) / Float(totalTime)
             print(Float(secondPassed) / Float(totalTime))
         } else {
             timer.invalidate()
             titleLabel.text = "DONE!"
             
             let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
             player = try! AVAudioPlayer(contentsOf: url!)
             player.play()
         }
     }
    
}
