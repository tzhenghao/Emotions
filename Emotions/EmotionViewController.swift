//
//  EmotionViewController.swift
//  Emotions
//
//  Created by Zheng Hao Tan on 6/20/15.
//  Copyright (c) 2015 Zheng Hao Tan. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController, FaceViewDataSource {

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = Int(translation.y/Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }

    var happiness : Int = 75 { // 0 = very sad, 100 = happiest
        didSet {
            // Bound it to have range between 0 and 100
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI();
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50 // Convert from 0 to 100 scale -> -1 to 1 range.
    }
}
