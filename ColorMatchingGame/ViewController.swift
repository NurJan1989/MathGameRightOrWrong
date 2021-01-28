//
//  ViewController.swift
//  ColorMatchingGame
//
//  Created by Macbook Air on 11/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var wrongAnswerCount: UILabel!
    @IBOutlet weak var rightAnswersCount: UILabel!
    @IBOutlet weak var mathQuestionLabel: UILabel!
    
    var firstNumber = 0
    var secondNumber = 0
    var resultsNumber = 0
    var getNumber = 0
    var rightCount: Int = 0
    var wrongCount: Int = 0
    var startTimer = 60
    var userDefaults = UserDefaults.standard
    var corrects: [String] = []
    var wrong: [String] = []
    var scheduledTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestion()
//        userDefaults.setValue(nil, forKey: "results")
        if let result = userDefaults.stringArray(forKey: "results") {
            corrects = result
        }
        if let result = userDefaults.stringArray(forKey: "wrongResults") {
            wrong = result
        }
        startTimer2()
        //nextQuestionButton.setTitle("Следующий Вопрос", for: .normal) // изменение имени кнопки
        countDownLabel.layer.cornerRadius = countDownLabel.frame.width / 2
        countDownLabel.layer.masksToBounds = true
        rightAnswersCount.layer.cornerRadius = rightAnswersCount.frame.width / 2
        rightAnswersCount.layer.masksToBounds = true
        wrongAnswerCount.layer.cornerRadius = 10
        wrongAnswerCount.layer.masksToBounds = true
        rightAnswersCount.layer.cornerRadius = 10
        rightAnswersCount.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        corrects = []
        wrong = []
        if let result = userDefaults.stringArray(forKey: "results") {
            corrects = result
        }
        if let result = userDefaults.stringArray(forKey: "wrongResults") {
            wrong = result
        }
    }
    
    func startTimer2() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        scheduledTimer.fire() //start
    }
    
    @objc func countDown() {
        if startTimer != 0 {
            countDownLabel.text = startTimer.description
            startTimer -= 1
        } else {
            scheduledTimer?.invalidate() // stop timer
            scheduledTimer = nil
            countDownLabel.text = "0"
            corrects.append(rightCount.description)
            wrong.append(wrongCount.description)
            userDefaults.setValue(corrects, forKey: "results")
            userDefaults.setValue(wrong, forKey: "wrongResults")
           // nextQuestionButton.setTitle("Перезапустить", for: .normal)
            unBlockButtons(block: true)
        }
    }
    
    func generateQuestion() {
        firstNumber = Int(arc4random_uniform(UInt32(100)))
        secondNumber = Int(arc4random_uniform(UInt32(100)))
        resultsNumber =  firstNumber + secondNumber
        getNumber = getRandomNumber()
        mathQuestionLabel.text = "\(firstNumber) + \(secondNumber) = \(getNumber)"
        unBlockButtons(block: true)
    }
    
    func getRandomNumber() -> Int {
        let firstNumberRandom = Int(arc4random_uniform(UInt32(4)))
        let secondNumberRandom = Int(arc4random_uniform(UInt32(4)))
        let resultNumberRandom = Int(arc4random_uniform(UInt32(100)))
        if firstNumberRandom >= secondNumberRandom {
            return resultsNumber
        } else {
            return resultNumberRandom
        }
    }
    
    func changeColorButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.yesButton.backgroundColor = .white
            self.noButton.backgroundColor = .white
        }
    }

    @IBAction func yesButtonPress(_ sender: UIButton) {
        unBlockButtons(block: false)
        if resultsNumber == getNumber {
            yesButton.backgroundColor = .green
            rightCount += 1
        } else {
            yesButton.backgroundColor = .red
            wrongCount += 1
        }
        nextQuestion()
    }
    
    func unBlockButtons(block: Bool) {
        yesButton.isUserInteractionEnabled = block
        noButton.isUserInteractionEnabled = block
    }
    
    @IBAction func noButtonPress(_ sender: UIButton) {
        unBlockButtons(block: false)
        if resultsNumber != getNumber {
            noButton.backgroundColor = .green
            rightCount += 1
        } else {
            noButton.backgroundColor = .red
            wrongCount += 1
        }
        nextQuestion()
    }
    
    func nextQuestion() {
        if startTimer == 0 {
            startTimer = 60
            startTimer2()
            wrongCount = 0
            rightCount = 0
        }
        rightAnswersCount.text = rightCount.description
        wrongAnswerCount.text = wrongCount.description
        generateQuestion()
        changeColorButton()
    }
    
//    @IBAction func nextActionButton(_ sender: UIButton){
//        if startTimer == 0 {
//            startTimer = 10
//            startTimer2()
//            wrongCount = 0
//            rightCount = 0
//          //  nextQuestionButton.setTitle("Следующий Вопрос", for: .normal)
//        }
//        rightAnswersCount.text = rightCount.description
//        wrongAnswerCount.text = wrongCount.description
//        generateQuestion()
//        yesButton.backgroundColor = .white
//        noButton.backgroundColor = .white
//        unBlockButtons(block: true)
//    }
//}
}
