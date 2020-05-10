//
//  ViewController.swift
//  FindIt
//
//  Created by Udhay on 2020-05-10.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionview: UICollectionView!
    
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
        // Do any additional setup after loading the view.
    }


}

