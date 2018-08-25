//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFirstQuestionUI()
        
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if (questionNumber < allQuestions.list.count - 1) {
        
            if sender.tag == 1 {
                pickedAnswer = true
            } else if sender.tag == 2 {
                pickedAnswer = false
            }
            
            checkAnswer(question: questionNumber)
            
            questionNumber = questionNumber + 1
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            updateUI()
        } else {
            print("end of quizz")
            endOfQuizzAlert()
        }
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        
        progressLabel.text = "\(questionNumber + 1)/13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    
    
    func updateFirstQuestionUI() {
        let firstQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
       
        updateUI()

    }
    
    func checkAnswer(question: Int) {

        let questionAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == questionAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            print("Wrong")
            ProgressHUD.showError("Wrong")
        }
        
    }
    
    func startOver() {
        questionNumber = 0
        score = 0

        updateFirstQuestionUI()
    }
    
    func endOfQuizzAlert() {
        let alertController = UIAlertController(title: "End of Quizz", message: "Restart?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed ok");
            self.startOver()
        }
    
        alertController.addAction(action1)

        self.present(alertController, animated: true, completion: nil)
    }
}
