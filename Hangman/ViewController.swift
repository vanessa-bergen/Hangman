//
//  ViewController.swift
//  Hangman
//
//  Created by Vanessa Bergen on 2019-09-12.
//  Copyright © 2019 Vanessa Bergen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var gameIsActive = false
    
    var startBtn = MyButton()
    
    var guessBtn = MyButton()
    
    var word = String()
    
    var letter = String()
    
    var numberOfGuesses = 0
    
    var numberRight = 0
    
    var guessedLetters = [String]()
    
    var allGuessedLetters = [String]()
    
    var guessedLettersLabel = MyLabel()
    
    //array to keep track of the index numbers that have been guessed
    var guesses = [Int]()
    
    var stand = UIImageView()
    var head = UIImageView()
    var arm1 = UIImageView()
    var arm2 = UIImageView()
    var body = UIImageView()
    var leg1 = UIImageView()
    var leg2 = UIImageView()
    
    var winLabel = UILabel()
    
    var dancingImage = UIImageView()
    
    var gameType = UISegmentedControl()
    
    let pointX = 20
    
    let pointY = 430
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addScreenGradient(color1: Colours.lightGreen, color2: Colours.orange, color3: Colours.pink)
        
        let margins = self.view.layoutMarginsGuide
        
        guessedLetters = []
        allGuessedLetters = []
        dancingImage = UIImageView(image: nil)
        
        //selector for single or multiplayer
        gameType.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        gameType.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameType)
        gameType.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        gameType.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        gameType.insertSegment(withTitle: "Single Player", at: 0, animated: true)
        gameType.insertSegment(withTitle: "Multi Player", at: 1, animated: true)
        gameType.selectedSegmentIndex = 0
        gameType.tintColor = Colours.darkBlue
    
        
        //button to start the game
        startBtn = MyButton.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startBtn)
        startBtn.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        // startBtn.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 100).isActive = true
        startBtn.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40).isActive = true
        startBtn.setTitle("Begin New Game", for: .normal)
        startBtn.setTitleColor(Colours.darkBlue, for: .normal)
        startBtn.addTarget(self, action: #selector(enterWord), for: .touchUpInside)
        if !gameIsActive {
            startBtn.isHidden = false
        }
        
        //lable that displays if the player won or lost
        winLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(winLabel)
        winLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        winLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        winLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        winLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        winLabel.textAlignment = .center
        
        
        //stand
        stand.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        stand.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stand)
        stand.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stand.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: -50).isActive = true
        stand.heightAnchor.constraint(equalToConstant: 150).isActive = true
        stand.widthAnchor.constraint(equalToConstant: 150).isActive = true
        stand.image = UIImage(named: "Stand")
        
        //head
        head.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        head.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(head)
        head.topAnchor.constraint(equalTo: stand.topAnchor, constant: 25).isActive = true
        head.leadingAnchor.constraint(equalTo: stand.leadingAnchor, constant: 88).isActive = true
        head.widthAnchor.constraint(equalToConstant: 32).isActive = true
        head.heightAnchor.constraint(equalToConstant: 32).isActive = true
        head.image = UIImage(named: "Head")
        
        //body
        body.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        body.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(body)
        body.topAnchor.constraint(equalTo: head.bottomAnchor, constant: -2).isActive = true
        //body.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: -25).isActive = true
        body.centerXAnchor.constraint(equalTo: head.centerXAnchor).isActive = true
        body.widthAnchor.constraint(equalToConstant: 60).isActive = true
        body.heightAnchor.constraint(equalToConstant: 60).isActive = true
        body.image = UIImage(named: "Body")
        
        //arm
        arm1.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        arm1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arm1)
        arm1.bottomAnchor.constraint(equalTo: body.centerYAnchor).isActive = true
        //arm1.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: -25).isActive = true
        arm1.trailingAnchor.constraint(equalTo: body.centerXAnchor).isActive = true
        arm1.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arm1.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arm1.image = UIImage(named: "Arm1")
        
        arm2.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        arm2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arm2)
        arm2.bottomAnchor.constraint(equalTo: body.centerYAnchor).isActive = true
        //arm2.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: -25).isActive = true
        arm2.leadingAnchor.constraint(equalTo: body.centerXAnchor).isActive = true
        arm2.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arm2.heightAnchor.constraint(equalToConstant: 24).isActive = true
        arm2.image = UIImage(named: "Arm2")
        
        //leg
        leg1.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        leg1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leg1)
        leg1.topAnchor.constraint(equalTo: body.bottomAnchor, constant: -5).isActive = true
        //leg1.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: -25).isActive = true
        leg1.trailingAnchor.constraint(equalTo: body.centerXAnchor).isActive = true
        leg1.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leg1.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leg1.image = UIImage(named: "Leg1")
        
        leg2.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        leg2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leg2)
        leg2.topAnchor.constraint(equalTo: body.bottomAnchor, constant: -5).isActive = true
        //leg2.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: -25).isActive = true
        leg2.leadingAnchor.constraint(equalTo: body.centerXAnchor).isActive = true
        leg2.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leg2.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leg2.image = UIImage(named: "Leg2")
        
        //hide the body to begin with
        head.isHidden = true
        body.isHidden = true
        arm1.isHidden = true
        arm2.isHidden = true
        leg1.isHidden = true
        leg2.isHidden = true
        
        
        
        //guess a letter button
        //hidden until the game starts
        guessBtn = MyButton.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        guessBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(guessBtn)
        guessBtn.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        //guessBtn.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 100).isActive = true
        guessBtn.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        guessBtn.setTitle("Guess A Letter", for: .normal)
        guessBtn.addTarget(self, action: #selector(enterLetter), for: .touchUpInside)
        guessBtn.isHidden = true
        
        
        //need to display all letters on the top
        guessedLettersLabel = MyLabel.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        guessedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(guessedLettersLabel)
        guessedLettersLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 70).isActive = true
        guessedLettersLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        guessedLettersLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    @objc func enterWord() {
        removeOldWord()
        
        //get whether single or multiplayer is selected
        let selectedGameType = gameType.selectedSegmentIndex
        
        //single player. autogenerate the word
        if selectedGameType == 0 {
            
            if let wordsFilePath = Bundle.main.path(forResource: "words", ofType: nil) {
                do {
                    let wordsString = try String(contentsOfFile: wordsFilePath)
                    
                    let wordLines = wordsString.components(separatedBy: .newlines)
                    
                    let randomLine = wordLines[numericCast(arc4random_uniform(numericCast(wordLines.count)))]
                    
                    //print(randomLine)
                    
                    self.word = randomLine
                    let numOfLetters = word.count
                    
                    addLetterLines(num: numOfLetters)

                    
                } catch { // contentsOfFile throws an error
                    print("Error: \(error)")
                }
            }
            else {
                print("failed trying to generate a word")
            }
            
        }
            
        //multiplayer, open popup to enter the word
        else {
            
            let customAlert = CustomAlertView()
            customAlert.wordEnter = true
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
            
        }
    }
    
    func addLetterLines(num: Int) {
        guesses = Array(repeating: 0, count: num)
        
        //adding the spaces for letters
        var pointX = self.pointX
        var pointY = self.pointY
        for _ in 1 ... num {
 
            let width = self.view.frame.size.width
    
            //if the width of the image doesn't fit in the margins (20), move it to the next line
            if pointX + 30 > Int(width) - 20 {
                //inserting dash to show word will finish on the next line
                let dashView = MyLetterLine.init(frame: CGRect(x: pointX, y: pointY - 10, width: 12, height: 24))
                self.view.addSubview(dashView)
                pointY += 30
                pointX = 20
            }
            let newView = MyLetterLine.init(frame: CGRect(x: pointX, y: pointY, width: 24, height: 24))
            
            pointX += 30
            self.view.addSubview(newView)
        }
        
        //set the game to be active
        //hide the start button, single or multi player select, show the guess button
        self.gameIsActive = true
        if self.gameIsActive {
            self.startBtn.isHidden = true
            self.gameType.isHidden = true
            self.guessBtn.isHidden = false
        }
        
        
    }
    
    @objc func enterLetter() {
        
        let customAlert = CustomAlertView()
        customAlert.wordEnter = false
        customAlert.allGuessedLetters = self.allGuessedLetters
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
        
    }
    
    
    func checkLetter(letter: String) {
        if !allGuessedLetters.contains(letter) {
            
            allGuessedLetters.append(letter)
        
            //print("checking the letter")
            if word.contains(letter) {
                
                //let index = word.firstIndex(of: Character(letter))
                //index if used to keep track of the position of the correctly guessed letter
                var index = 0
                //guessed character
                let character = Character(letter)
                //i is used to keep track of the postion of where the letter is placed on the screen
                var i = 0
                //pointX starts at 20 (margins)
                var pointX = 20
                var pointY = self.pointY - 12
                let width = self.view.frame.width
                for char in word {
                    //if the letter will extend off the screen, start a new line
                    //this is based off the starting point 20 plus where the letter will be placed
                    if pointX + 30 * (i + 1) > Int(width) - 20 {
                        //print("next line")
                        pointY += 30
                        i = 0
                    }
                    
                    //point x is set to 20 + 30 times the postion
                    pointX += 30 * i

                    //if the guessed character equals a character in the word
                    if char == character {
                        //increment the number of write guesses
                        numberRight += 1
                        //set the position in the guesses array to 1
                        //this keeps track of which letters have been correctly guessed so that we know which characters are missing at the end of the game
                        guesses[index] = 1
                        
                        
                        
                        //adding the letter view
                        let newView = MyGuessedLetter.init(frame: CGRect(x: pointX, y: pointY, width: 24, height: 24))
                        newView.text = String(character).uppercased()
                        view.addSubview(newView)
                        
                    }
                    //default pointX back to 20 otherwise for cases with mulitple letters in the same word it will be screwed up
                    pointX = 20
                    i += 1
                    index += 1
                }
                
                //print(index!)
                //if the number of right guesses equals the number of letters in the word, then the game is won
                if numberRight == self.word.count {
                    
                    gameIsActive = false
                    winningAnimation()
                }
            }
                //if the guess is wrong:
                //add the guessed letter to the top
                //show a body part
                //if number of wrong guesses adds up to 6 then the game is ended
            else {
                numberOfGuesses += 1
                guessedLetters.append(letter.uppercased())
                guessedLetters.sort()
                var text = ""
                for letter in guessedLetters {
                    text += "\(letter) "
                }
                
                guessedLettersLabel.text = text
                
                switch numberOfGuesses {
                case 1:
                    head.isHidden = false
                case 2:
                    body.isHidden = false
                case 3:
                    arm1.isHidden = false
                case 4:
                    arm2.isHidden = false
                case 5:
                    leg1.isHidden = false
                default:
                    leg2.isHidden = false
                }
                
                if numberOfGuesses == 6 {
                    
                    gameIsActive = false
                    losingAnimation()
                }
                
            }
            
            if !gameIsActive {
                guessBtn.isHidden = true
                startBtn.isHidden = false
                gameType.isHidden = false
                
            }
        }
        
    }
    
    func removeOldWord() {
        //removing all subviews in the class MyLetterLine
        for case let line as MyLetterLine in self.view.subviews {
            line.removeFromSuperview()
        }
        //removing the guessed letters
        for case let letter as MyGuessedLetter in self.view.subviews {
            letter.removeFromSuperview()
        }
        //clearing the wrong letters array
        guessedLetters.removeAll()
        allGuessedLetters.removeAll()
        //print("guessed letters \(guessedLetters)")
        guessedLettersLabel.text = ""
        numberRight = 0
        numberOfGuesses = 0
        
        //hiding the man
        head.isHidden = true
        body.isHidden = true
        arm1.isHidden = true
        arm2.isHidden = true
        leg1.isHidden = true
        leg2.isHidden = true
        
        winLabel.isHidden = true
        
        dancingImage.removeFromSuperview()
    }
    
    func winningAnimation() {
        //print(winLabel.frame)
        winLabel.isHidden = false
        winLabel.textColor = UIColor.purple
        winLabel.text = "You Win"
        winLabel.font = UIFont.boldSystemFont(ofSize: 80)
        //Rotate animation
        let rotation: CABasicAnimation = CABasicAnimation(keyPath:
            "transform.rotation.z")
        rotation.toValue = 0
        rotation.fromValue = Float.pi
        
        //Scale animation
        let scale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale.toValue = 1
        scale.fromValue = 1/4
        
        let opacity: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        
        //Adding animations to group
        let group = CAAnimationGroup()
        group.animations = [scale, opacity, rotation]
        group.duration = 5
        
        self.winLabel.layer.add(group, forKey: nil)
        
        let dancingGif = UIImage.gifImageWithName("dancing")
        dancingImage = UIImageView(image: dancingGif)
        dancingImage.backgroundColor = UIColor.clear
        dancingImage.frame = CGRect(x: 100, y: 140.0, width: self.view.frame.size.width / 2, height: self.view.frame.height / 2)
        view.addSubview(dancingImage)
    }
    
    func losingAnimation() {
        winLabel.isHidden = false
        winLabel.textColor = Colours.darkRed
        winLabel.text = "You Lost"
        winLabel.font = UIFont.boldSystemFont(ofSize: 60)
        //Rotate animation
        let rotation: CABasicAnimation = CABasicAnimation(keyPath:
            "transform.rotation.z")
        rotation.toValue = 0
        rotation.fromValue = -Float.pi
        
        //Scale animation
        let scale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale.toValue = 1
        scale.fromValue = 1/4
        
        let opacity: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        
        //Adding animations to group
        let group = CAAnimationGroup()
        group.animations = [scale, opacity, rotation]
        group.duration = 5
        
        self.winLabel.layer.add(group, forKey: nil)
        
        
        let dancingGif = UIImage.gifImageWithName("sad")
        dancingImage = UIImageView(image: dancingGif)
        dancingImage.backgroundColor = UIColor.clear
        let pointX = self.view.frame.width / 2 - 125
        let pointY = self.view.frame.height / 2 - 100
        dancingImage.frame = CGRect(x: pointX, y: pointY, width: 250, height: 150)
        view.addSubview(dancingImage)
        
        fillInRemaining()
 
    }
    
    func fillInRemaining() {
        //adding in the remaining letters in red
        
        //i is used to keep track of the postion of where the letter is placed on the screen
        var i = 0
        //pointX starts at 20 (margins)
        var pointX = self.pointX
        var pointY = self.pointY - 12
        let width = self.view.frame.width
        for char in word {
            //if the width of the image doesn't fit in the margins (20), move it to the next line
            if pointX + 30 > Int(width) - 20 {
                pointY += 30
                pointX = 20
            }
            
            if guesses[i] == 0 {
                //adding the letter view
                let newView = MyGuessedLetter.init(frame: CGRect(x: pointX, y: pointY, width: 24, height: 24))
                newView.text = String(char).uppercased()
                newView.textColor = UIColor.red
                view.addSubview(newView)
            }
            pointX += 30
            i += 1
            
        }
    }


}

class MyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeButton() {
        self.setTitleColor(Colours.darkBlue, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
}

class MyLabel: UILabel {
    override init(frame: CGRect){
        super.init(frame: frame)
        initializeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLabel() {
        self.textColor = Colours.darkBlue
        self.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
}

class MyLetterLine: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeImage() {
        self.image = UIImage(named: "LetterLine")
    }
}

class MyGuessedLetter: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLetter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLetter() {
        self.textColor = UIColor.black
        self.font = UIFont.boldSystemFont(ofSize: 20)
        self.textAlignment = .center
    }
}


extension ViewController: CustomAlertViewDelegate {
    
    func wordEntered(word: String) {
        self.word = word.lowercased()
        let numOfLetters = word.count
        self.addLetterLines(num: numOfLetters)
    }
    
    func charEntered(char: String) {
        self.checkLetter(letter: char)
    }
    
}
