//
//  FaceView.swift
//  Emotions
//
//  Created by Zheng Hao Tan on 6/20/15.
//  Copyright (c) 2015 Zheng Hao Tan. All rights reserved.
//

import UIKit

class FaceView: UIView {

    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }

    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }

    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    

    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
    }
}
