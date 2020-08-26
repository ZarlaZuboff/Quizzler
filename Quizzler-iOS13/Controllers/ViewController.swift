//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Олег Комисаренко on 13.06.2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Initiate timer
    var timer: Timer?
    
    // Initiate quiz
    var quiz = Quiz()
    
    // Get actual questions
    lazy var questions = quiz.quizGame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else {
            return
        }
        if quiz.checkThis(answer) {
            sender.backgroundColor = UIColor.green
            quiz.incrementScore()
            initTimer()
        } else {
            sender.backgroundColor = UIColor.red
            initTimer()
            }
        quiz.nextQuestion()
    }
    
    @objc func updateUI() {
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        scoreLabel.text = "Score: \(quiz.getCurrentScore())"
        progressView.progress += 1.0 / Float(questions.count)
        
        if questions.count == quiz.currentQuestion {
            stopQuiz()
        } else {
            questionLabel.text = questions[quiz.currentQuestion].q
        }
    }
    
    func stopQuiz() {
        scoreLabel.isHidden = true
        questionLabel.text = "Time is over\nYour score: \(quiz.getCurrentScore())"
        trueButton.isHidden = true
        falseButton.isHidden = true
        progressView.isHidden = true
    }
    
    func initTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
}
