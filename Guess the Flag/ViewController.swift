//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Akbar Mirza on 2/7/17.
//  Copyright © 2017 Akbar Mirza. All rights reserved.
//

import GameplayKit // add randomness
import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Properties
    var countries = [String]()
    var correctAnswer = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // add our countries to the countries array
        countries += ["estonia", "france", "germany", "ireland", "italy",
                      "monaco", "nigeria", "poland", "russia", "spain",
                      "uk", "us"]
        
        // add a borderWidth to the buttons
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // set the color of the border
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // start our game
        askQuestion(action: nil)
        
        // reset scoreLabel
        scoreLabel.text = "Score: \(score)"
    }
    
    func askQuestion(action: UIAlertAction!) {
        
        // shuffle our countries array
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        // generate a random number between 0 and 2 inclusive to be our correctAnswer
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        // set the title to the name of the correctAnswer
        title = countries[correctAnswer].uppercased()
        
        // select the first 3 (random) countries
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            self.score += 1
        } else {
            title = "Wrong"
            self.score -= 1
        }
        
        // update scoreLabel
        scoreLabel.text = "Score: \(score)"
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        // present the specified view controller
        present(ac, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

