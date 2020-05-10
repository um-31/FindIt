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
        var generatedCardArray = [Card]()
        var generatedRandomNumbers = [Int]()
        while generatedRandomNumbers.count < 8
        {
            
            let randomnumber = arc4random_uniform(13) + 1
            
            if !generatedRandomNumbers.contains(Int(randomnumber))
            {
            
                
                generatedRandomNumbers.append(Int(randomnumber))
                
                
                print(randomnumber)
                
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardOne)
                
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomnumber)"
                generatedCardArray.append(cardTwo)
            }
            
        }
        generatedCardArray.shuffle()
        return generatedCardArray
    }
}
