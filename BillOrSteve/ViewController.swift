//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var steve: UIButton!
    @IBOutlet weak var bill: UIButton!
    
    var steveAndBill: [String:[String]] = [:]
    var currentScore = 0
    var numberOfGuesses = 0
    func createFacts() {
        steveAndBill["Steve Jobs"] = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."
        ]
        steveAndBill["Bill Gates"] = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create the dictionary for Steve's and Bill's random facts
        createFacts()
        
        showFact()
    }

    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    func getRandomFact() -> (String,String)? {
        var person = randomPerson()
        let steveFactCount = steveAndBill["Steve Jobs"]?.count
        let billFactCount = steveAndBill["Bill Gates"]?.count
        
        if steveFactCount == 0 && billFactCount == 0 {
            return nil
        }
        else if steveFactCount == 0 {
            person = "Bill Gates"
        }
        else if billFactCount == 0 {
            person = "Steve Jobs"
        }
        
        if let facts = steveAndBill[person] {
            let factNumber = randomNumberFromZeroTo(facts.count)
            return (person, facts[factNumber])
        }
        else {
            print("could not get the facts array from \(person)")
            return nil
        }
    }

    func showFact() {
        if let fact: (person:String, factString:String) = getRandomFact() {
            factLabel.text = fact.factString
        }
        else {
            factLabel.text = ""
        }
    }
    
    @IBAction func steveButton(sender: AnyObject) {
        if var facts = steveAndBill["Steve Jobs"] {
            if let factInWorks = factLabel.text {
                for fact in facts{
                    if fact == factInWorks {
                        currentScore += 1
                        break;
                    }
                }
                if let index = facts.indexOf(factInWorks) {
                    facts.removeAtIndex(index)
                    steveAndBill["Steve Jobs"] = facts
                }
                else {
                    if let index = steveAndBill["Bill Gates"]?.indexOf(factInWorks) {
                        steveAndBill["Bill Gates"]?.removeAtIndex(index)
                    }
                }
                scoreLabel.text = String(currentScore)
                showFact()
            }
        }
    }
    
    @IBAction func billButton(sender: AnyObject) {
        if var facts = steveAndBill["Bill Gates"] {
            if let factInWorks = factLabel.text {
                for fact in facts{
                    if fact == factInWorks {
                        currentScore += 1
                        break;
                    }
                }
                if let index = facts.indexOf(factInWorks) {
                    facts.removeAtIndex(index)
                    steveAndBill["Bill Gates"] = facts
                }
                else {
                    if let index = steveAndBill["Steve Jobs"]?.indexOf(factInWorks) {
                        steveAndBill["Steve Jobs"]?.removeAtIndex(index)
                    }
                }
                scoreLabel.text = String(currentScore)
                showFact()
            }
        }
    }
}
