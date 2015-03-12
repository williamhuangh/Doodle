//
//  EquationVariable.swift
//  Doodle
//
//  Created by William Huang on 3/11/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class EquationVariable: UIView {
    
    private var value = 0
    private var valueLabel: UILabel!
    
    func setVariableValue(val: Int){
        self.value = val
        if self.valueLabel == nil {
            self.valueLabel = UILabel(frame: CGRectMake(0, 0, 40, 40))
            self.valueLabel.textColor = UIColor.blackColor()
            self.valueLabel.textAlignment = .Center
        }
        self.valueLabel.text = "\(value)"
        setNeedsDisplay()
    }
    
    func getVariableValue() -> Int{
        return value
    }
    
    override func drawRect(rect: CGRect) {
        if let label = valueLabel {
            label.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)
            self.addSubview(label)
        }
    }
    
}
