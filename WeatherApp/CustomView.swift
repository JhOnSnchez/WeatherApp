//
//  CustomView.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/9/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    override func awakeFromNib() {
        configureView()
    }
    
    override func prepareForInterfaceBuilder() {
        configureView()
    }
    
    func configureView(){
        self.layer.cornerRadius = 10.0
    }

}
