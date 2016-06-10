//
//  DayForecast.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/9/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import Foundation

class DayForecast{
    private var _day: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _weatherIcon: String!
    


    var day: String{
        return _day
    }
    
    var maxTemp: String{
        return _maxTemp
    }
    
    var minTemp: String{
        return _minTemp
    }
    
    var weatherIcon: String{
        return _weatherIcon
    }
    
    required init(day: String, maxT: String, minT: String, icon: String){
        _day = day
        _maxTemp = maxT
        _minTemp = minT
        _weatherIcon = icon
    }
    

}