//
//  EmotionViewController.swift
//  Emotions
//
//  Created by Zheng Hao Tan on 6/20/15.
//  Copyright (c) 2015 Zheng Hao Tan. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController {

    var happiness : Int = 50 { // 0 = very sad, 100 = happiest
        didSet {
            // Bound it to have range between 0 and 100
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI();
        }
    }
    
    func updateUI() {
        
    }
}
