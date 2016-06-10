//
//  customLabel.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/7/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit

@IBDesignable
class customLabel: UILabel {


    
    override func awakeFromNib() {
        setupLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        setupLabel()
    }
    
    func setupLabel(){
        let rotation: CGFloat = CGFloat(-M_PI / 2)
        self.transform = CGAffineTransformMakeRotation(rotation)
        self.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
        self.textColor = UIColor.whiteColor()
        
    }

}
