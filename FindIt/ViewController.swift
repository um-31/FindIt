//
//  ViewController.swift
//  FindIt
//
//  Created by Udhay on 2020-05-10.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     @IBOutlet weak var turn_counter: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel()
    var cardArray = [Card]()
    var count_flip = 0;
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var millisecond:Float = 30 * 1000

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        timerLabel.textColor = UIColor.black
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerLeft), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Play sound
//        SoundManager.playSound(.shuffle)
    }
    
    
    
    @objc func timerLeft() {
        
        millisecond -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", millisecond/1000)
        
        //set the label
        timerLabel.text = "Time Remaining : \(seconds) "
        
        //when timer has reached 0
        if millisecond <= 0
        {
            //stop the timer
            timer?.invalidate()
            
            timerLabel.textColor = UIColor.red
            
            //check if there are any cards unmatched
            checkGameEnded()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)  as! CardCollectionViewCell
        
        //get the card to set image from the cardArray
        let card = cardArray[indexPath.row]
        
        //set backimageView of the card
        cell.setCard(card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Check if there is any time left(so that the UI avtions can be stopped after 0 seconds)
        if millisecond <= 0 {
            return
        }
        
        count_flip = count_flip+1;
        
        //get the selected card
        let card = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //check if the card is flipped
        if !card.card!.isFlipped && !card.card!.isMatched
        {
            //play sound
//            SoundManager.playSound(.flip)
            
            //filp the card
            card.flip()
            
            
            //check if the card flipped is first
            if firstFlippedCardIndex == nil
            {
                
                //This is the first card beiing flipped
                firstFlippedCardIndex = indexPath
            }
            else
            {
                //This is the second card being flipped
                
                //perform the matching Logic
                checkForMatches(indexPath)
            }
        }
        
    }
    
    
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        //get the cells for two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get the Cards for two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName
        {
            //It's a match
            
            //Set the status of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //delay the sound of match
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                //play sound
//                SoundManager.playSound(.match)
                
                //remove the matched pairs
                cardOneCell?.remove()
                cardTwoCell?.remove()
            }
            
            //Check if there are any cards left unmatched
            checkGameEnded()
        }
        else{
            //It's not a match
            
            //flip back the cards
            cardOneCell?.filpBack()
            cardTwoCell?.filpBack()
            
            //delay the sound
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
                //Play sound
//                SoundManager.playSound(.nomatch)
            }
        }
        
        //tell the collectionView to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
            cardOne.isFlipped = false
        }
        
        //reset the indexpath to nil
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded()
    {
        //Check if there are any cards unmatched
        var isWon = true
        
        for card in cardArray {
            
            if !card.isMatched {
                
                isWon = false
                break
                
            }
        }
        //Alert variable
        var title = ""
        var message = ""
        
        //If not, then user won
        if isWon {
            
            if millisecond > 0 {
                
                timer?.invalidate()
                
            }
            
            title = "Conguralations"
            message = "You Won"
            
        }
        else {
            //If there are unmatched cards, check if there is any time left
            if millisecond > 0 {
                return
            }
            
            title = "Game Over"
            message = "You Lost"
        }
        
        //Show user won/lost alert
        showAlert(title, message)
        
    }
    
    
    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        
        let alertAction2 = UIAlertAction(title: "Replay", style: .default, handler: nil)
        
        
        alert.addAction(alertAction)
        alert.addAction(alertAction2)
        
        present(alert, animated: true, completion: nil)
    }
    

}

