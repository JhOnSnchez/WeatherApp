//
//  Location.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/7/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import Foundation

class Location {
    private var _locationName: String!
    private var _temperature: String!
    private var _sunset: String!
    private var _windSpeed: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _today: String!
    private var _zipcode: String!
    private var _desc: String!

    
    var desc: String{
        if _desc == nil{
            _desc = ""
        }
        
        return _desc
    }
    
    var speed: String{
        if _windSpeed == nil{
            _windSpeed = ""
        }
        
        return _windSpeed
    }
    
    var sunset: String{
        if _sunset == nil{
            _sunset = ""
        }
        
         return "Sunset \(_sunset)"
    }
    
    
    var today: String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE h:mm a"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        _today = DateInFormat
        return _today
    }
    
    var temperature: String{
        if _temperature == nil{
            _temperature = ""
        }
        return _temperature
    }
    
    var locationName: String{
        if _locationName == nil{
            _locationName = ""
        }
        return _locationName
    }
    
    var maxTemp: String{
        if _maxTemp == nil{
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    var minTemp: String{
        if _minTemp == nil{
            _minTemp = ""
        }
        return _minTemp
    }
    
    required init(){
        
    }
    
        
    func downloadCurrentWeatherInfoForZip(zip: String){
        let urlStr = "\(apiCurrentUrl)\(apiKey)&zip=\(zip)"
        let url = NSURL(string: urlStr)!
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if let result = data{
            
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(result, options: .AllowFragments)
                    if let resultDictionary = json as? Dictionary<String, AnyObject>{
                        
                        //get location name
                        if let locationName = resultDictionary["name"] as? String{
                            self._locationName = locationName
                        }
                        
                        
                        //get main description
                        if let weather = resultDictionary["weather"] as? [Dictionary<String, AnyObject>]{
                            if let main = weather[0]["icon"] as? String{
                                self._desc = main
                            }
                        }
                        
                        //get temperature, min and max
                        if let temps = resultDictionary["main"] as? Dictionary<String, AnyObject>{
                            
                            if let temp = temps["temp"] as? Int{
                                self._temperature = "\(temp)°"
                            }
                            
                            if let max = temps["temp_max"] as? Int{
                                self._maxTemp = "\(max)°"
                            }
                            
                            if let min = temps["temp_min"] as? Int{
                                self._minTemp = "\(min)°"
                            }
                            
                        }
                        
                        //get wind info
                        if let wind = resultDictionary["wind"] as? Dictionary<String, AnyObject>{
                            if let speed = wind["speed"] as? Int{
                                self._windSpeed = "\(speed) m/h"
                            }
                        }
                        
                        //get sunset 
                        if let sys = resultDictionary["sys"] as? Dictionary<String, AnyObject>{
                            if let dateTime = sys["sunset"] as? Double{
                                self._sunset = self.convertDateToFormat(dateTime, format: "hh:mm a")
                            }
                        }
                        
                    }
            
                    
                }catch{
                    print("Error")
                }
            }
            }.resume()
        
        downloadForecastInfo(zip)
        
    }
    
    
    
    func downloadForecastInfo(zip: String){
        var dayArr = [DayForecast]()
        let urlStr = "\(apiUrlStr)\(apiKey)&zip=\(zip)"
        let url = NSURL(string: urlStr)!
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let result = data{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(result, options: .AllowFragments)
                    if let resultDictionary = json as? Dictionary<String, AnyObject>{
                        var max: Double = 0
                        var min: Double = 0
                        var dayName = ""
                        var icon = ""
                        
                        if let list = resultDictionary["list"] as? [Dictionary<String, AnyObject>]{
                            for x in 0 ..< list.count{
                                if let dateTime = list[x]["dt"] as? Double{
                                    dayName = self.convertDateToFormat(dateTime, format: "EE")
                                    if let temp = list[x]["temp"] as? Dictionary<String, AnyObject>{
                                         max = (temp["max"] as? Double)!
                                         min = (temp["min"] as? Double)!
                                        
                                    }
                                    
                                    if let weather = list[x]["weather"] as? [Dictionary<String, AnyObject>]{
                                        if let iconName = weather[0]["icon"] as? String{
                                            icon = iconName
                                        }
                                    }

                                }
                                
                                let day = DayForecast(day: dayName.uppercaseString, maxT: "\(Int(max))", minT: "\(Int(min))", icon: icon)
                                dayArr.append(day)
                                
                                
                            }
                        }
                    }
                    let noti = NSNotification(name: "downloadFinished", object: dayArr, userInfo: nil)
                    NSNotificationCenter.defaultCenter().postNotification(noti)
                } catch{
                    print("Error")
                }
            }

            
        }.resume()
        
        
    }
    
    func convertDateToFormat(date: Double, format: String) -> String{
        let date = NSDate(timeIntervalSince1970: date)
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        let DateInFormat:String = dateFormatter.stringFromDate(date)
        return "\(DateInFormat)"
    }
    
    
}
