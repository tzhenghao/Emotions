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
    
    // Constant ratios.
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }

    private enum Eye { case Left, Right }
    
    // REQUIRES: A left or right eye.
    // EFFECTS: Returns the path for the left or right eye.
    private func bezierPathForEye(whicheye: Eye) -> UIBezierPath {
        
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        
        eyeCenter.y -= eyeVerticalOffset
        
        switch whicheye {
        case .Left:
            eyeCenter.x -= eyeHorizontalSeparation/2
        case .Right:
            eyeCenter.x += eyeHorizontalSeparation/2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        
        return path
    }

    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        // Draw the eyes.
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        // Draw the smile.
        //let initialSmile = 0.85
        //let smilePath = bezierPathForSmile(initialSmile)
        //smilePath.stroke()
    }
}
