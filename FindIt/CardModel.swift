//
//  CardModel.swift
//  FindIt
//
//  Created by Udhay on 2020-05-10.
//  Copyright © 2020 Udhay. All rights reserved.
//

import Foundation

class CardModel
{
    func getCards() -> [Card]
    {
        //Declare array to store the generated cards
        var generatedCardArray = [Card]()
        
        //Array to store the generated random numbers
        var generatedRandomNumbers = [Int]()
        
        //Randomly generate the pairs of cards
        while generatedRandomNumbers.count < 8
        {
            //Generate random numbers
            let randomnumber = arc4random_uniform(13) + 1
            
            //Check that the generated random numbers are random
            if !generatedRandomNumbers.contains(Int(randomnumber))
            {
            
                //Store the random number in the array
                generatedRandomNumbers.append(Int(randomnumber))
                
                //Log the random number
                print(randomnumber)
                
                //First card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardOne)
                
                //Second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardTwo)
            }
            
        }
        
        //Randomize the array
        generatedCardArray.shuffle()
        
        //return the generated array of cards
        return generatedCardArray
    }
}
