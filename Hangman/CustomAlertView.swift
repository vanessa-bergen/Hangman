//
//  CustomAlertView.swift
//  Hangman
//
//  Created by Vanessa Bergen on 2019-09-27.
//  Copyright © 2019 Vanessa Bergen. All rights reserved.
//
protocol CustomAlertViewDelegate: class {

    func wordEntered(word: String)
    func charEntered(char: String)
}

import Foundation
import UIKit

class CustomAlertView: UIViewController, UITextFieldDelegate  {
    var alertView = UIView()
    var titleLabel = UILabel()
    var textField = UITextField()
    var enterBtn = UIButton()
    var errMsg = UILabel()
    
    var wordEnter = Bool()
    
    var allGuessedLetters = [String]()
    
    var delegate: CustomAlertViewDelegate?
    
    // var delegate = CustomAlertViewDelegate?
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    var width: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        width = self.view.frame.width - 40
        //print(width)
        alertView.frame = CGRect(x: 20, y: 100, width: width, height: 200)
        self.view.addSubview(alertView)
        
       
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //this forces the layout of subviews before drawing
        view.layoutIfNeeded()
        
    }
    
    func setupView() {
        
        alertView.backgroundColor = alertViewGrayColor
        alertView.layer.cornerRadius = 15
        alertView.backgroundImages()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        titleLabel.frame = CGRect(x: (width * 0.5) / 2, y: 30, width: width * 0.5, height: 40)
        alertView.addSubview(titleLabel)
        titleLabel.text = "Enter Secret Word"
        titleLabel.textColor = Colours.darkBlue
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = alertViewGrayColor
        
        textField.frame = CGRect(x: (width * 0.1) / 2, y: 80, width: width * 0.9, height: 40)
        textField.placeholder = "Type A Word"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colours.darkBlue.cgColor
        textField.backgroundColor = alertViewGrayColor
        alertView.addSubview(textField)
        textField.delegate = self
        textField.becomeFirstResponder()
        
        errMsg.frame = CGRect(x: (width * 0.1) / 2, y: 122, width: width * 0.9, height: 20)
        errMsg.text = "Not a valid word."
        errMsg.textAlignment = .center
        errMsg.textColor = UIColor.red
        errMsg.backgroundColor = alertViewGrayColor
        alertView.addSubview(errMsg)
        errMsg.isHidden = true
        
        
        enterBtn.frame = CGRect(x: (width * 0.5) / 2, y: 150, width: width * 0.5, height: 40)
        alertView.addSubview(enterBtn)
        enterBtn.backgroundColor = Colours.darkBlue
        enterBtn.layer.cornerRadius = 15
        enterBtn.setTitle("Enter", for: .normal)
        if wordEnter {
            titleLabel.text = "Enter Secret Word"
            textField.placeholder = "Type A Word"
            enterBtn.addTarget(self, action: #selector(checkWord), for: .touchUpInside)
        }
        else {
            titleLabel.text = "Enter A Guess"
            textField.placeholder = "Type A Character"
            enterBtn.addTarget(self, action: #selector(checkChar), for: .touchUpInside)
        }
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    //test fields, clear keyboard when enter pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if wordEnter {
            checkWord()
        }
        else {
           checkChar()
        }
        return true
    }
    
    @objc func checkWord() {
        // let letters = CharacterSet.letters
        errMsg.text = "Not a valid word."
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        //use charcterset.inverted to see if it returns any special characters or numbers, then it is not a valid word
        if let word = textField.text, word.count > 0, word.rangeOfCharacter(from: characterset.inverted) == nil {
            delegate?.wordEntered(word: word)
            self.dismiss(animated: true, completion: nil)
        }
        else {
            errMsg.isHidden = false
            textField.becomeFirstResponder()
        }
        
    }
    
    @objc func checkChar() {
        errMsg.text = "Not a valid character."
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        //use charcterset.inverted to see if it returns any special characters or numbers, then it is not a valid word
        if let char = textField.text?.lowercased(), char.count == 1, char.rangeOfCharacter(from: characterset.inverted) == nil, !allGuessedLetters.contains(char) {
            delegate?.charEntered(char: char)
            self.dismiss(animated: true, completion: nil)
        }
        else if let char = textField.text?.lowercased(), allGuessedLetters.contains(char) {
            errMsg.text = "Character already guessed"
            errMsg.isHidden = false
            textField.becomeFirstResponder()
        }
        else {
            errMsg.isHidden = false
            textField.becomeFirstResponder()
        }
    }
}

extension UIView {
    
    
    func backgroundImages() {
        var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        for _ in 0 ... 60 {
            let randLetter = Int.random(in: 0...25)
            let letter = alphabet[randLetter]
            let fontSize = CGFloat.random(in: 16...30)
            let sizeOfView = 35
            let pointX = Int.random(in: 0 ..< Int(self.bounds.width) - sizeOfView)
            let pointY = Int.random(in: 0 ..< Int(self.bounds.height) - sizeOfView)
            let blueValue = CGFloat.random(in: 0..<1)
            let greenValue = CGFloat.random(in: 0..<1)
            let redValue = CGFloat.random(in: 0..<1)
            let rotationAngle = CGFloat.random(in: 0..<1)
            
            let myView = UILabel()
            myView.frame = CGRect(x: pointX, y: pointY, width: sizeOfView, height: sizeOfView)
            self.addSubview(myView)
            myView.text = letter
            myView.textColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.5)
            //myView.textColor = UIColor.red
            myView.font = UIFont.boldSystemFont(ofSize: fontSize)
            //myView.backgroundColor = UIColor(red: CGFloat(colourRed/255), green: CGFloat(colourGreen/255), blue: CGFloat(colourBlue/255), alpha: 1.0)
            myView.transform = CGAffineTransform(rotationAngle: rotationAngle * CGFloat.pi)
            
        }
    }
}


