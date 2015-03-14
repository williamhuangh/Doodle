//
//  LogicCard.swift
//  Doodle
//
//  Created by William Huang on 3/12/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class LogicCard: UIView {
    
    enum Shape {
        case Circle
        case Triangle
        case Square
    }
    
    private var shape: Shape!
    private var color: UIColor!
    private var matched = false
    
    func setShape(shapeVal: Int, colorVal: Int){
        switch shapeVal {
        case 0:
            self.shape = Shape.Circle
        case 1:
            self.shape = Shape.Triangle
        case 2:
            self.shape = Shape.Square
        default:
            self.shape = Shape.Circle
        }
        switch colorVal {
        case 0:
            color = UIColor.cyanColor()
        case 1:
            color = UIColor.magentaColor()
        case 2:
            color = UIColor.yellowColor()
        default:
            color = UIColor.cyanColor()
        }
        matched = false
        setNeedsDisplay()
    }
    
    func drawShape(){
        if self.shape == Shape.Circle{
            var path = UIBezierPath()
            path.addArcWithCenter(CGPointMake(self.frame.width / 2.0, self.frame.height / 2.0), radius: 30.0, startAngle: 0.0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
            path.lineWidth = 3.0
            self.color.setStroke()
            UIColor.blackColor().setFill()
            path.fill()
            path.stroke()
        } else if self.shape == Shape.Triangle{
            var path = UIBezierPath(rect: self.frame)
            path.moveToPoint(CGPointMake(self.frame.width / 2.0, self.frame.height / 4.0))
            path.addLineToPoint(CGPointMake(self.frame.width / 4.0, self.frame.height / 4.0 * 3.0))
            path.addLineToPoint(CGPointMake(self.frame.width / 4.0 * 3.0, self.frame.height / 4.0 * 3.0))
            path.closePath()
            path.lineWidth = 3.0
            self.color.setStroke()
            UIColor.blackColor().setFill()
            path.fill()
            path.stroke()
        } else {
            var path = UIBezierPath(rect: self.frame)
            path.moveToPoint(CGPointMake(self.frame.width / 4.0, self.frame.height / 4.0))
            path.addLineToPoint(CGPointMake(self.frame.width / 4.0 * 3.0, self.frame.height / 4.0))
            path.addLineToPoint(CGPointMake(self.frame.width / 4.0 * 3.0, self.frame.height / 4.0 * 3.0))
            path.addLineToPoint(CGPointMake(self.frame.width / 4.0, self.frame.height / 4.0 * 3.0))
            path.closePath()
            path.lineWidth = 3.0
            self.color.setStroke()
            UIColor.blackColor().setFill()
            path.fill()
            path.stroke()
        }
    }
    
    func getShape() -> Shape {
        return shape
    }
    
    func getColor() -> UIColor {
        return color
    }
    
    func getMatched() -> Bool {
        return matched
    }
    
    func setMatched(){
        matched = true
    }
    
    override func drawRect(rect: CGRect) {
        if let drawing = self.shape {
            drawShape()
        }
    }
}
