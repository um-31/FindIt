//
//  CardCollectionViewCell.swift
//  FindIt
//
//  Created by Udhay on 2020-05-10.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card)
    {
        self.card = card
        
        backImageView.image = UIImage.init(named: card.imageName)
        
        
        if card.isMatched
        {
            
            
            frontImageView.alpha = 0
            backImageView.alpha = 0
            
            return
        }
        else{
            
            frontImageView.alpha = 1
            backImageView.alpha = 1
        }
        
        if card.isFlipped
        {
            //filp the card
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
        else
        {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        }
    }
    
    func flip()
    {
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: nil)
        
        card?.isFlipped = true
    }
    
}
