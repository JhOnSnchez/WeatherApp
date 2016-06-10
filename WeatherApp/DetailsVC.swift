//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/7/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
     let location = Location()
    var dayArray = [DayForecast]()
    var zip: String!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var zipTxtField: UITextField!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var sideViewTrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var firstDatLbl: customLabel!
    @IBOutlet weak var firstDayImgView: UIImageView!
    @IBOutlet weak var secondDayLbl: customLabel!
    @IBOutlet weak var secondDayImgView: UIImageView!
    @IBOutlet weak var thirdDayLbl: customLabel!
    @IBOutlet weak var thirdDayImgView: UIImageView!
    @IBOutlet weak var fourthDayLbl: customLabel!
    @IBOutlet weak var fourtDayImgView: UIImageView!
    @IBOutlet weak var fifthDayLbl: customLabel!
    @IBOutlet weak var fifthDayImgView: UIImageView!
    @IBOutlet weak var sixthDayLbl: customLabel!
    @IBOutlet weak var sixthDayImgView: UIImageView!
    @IBOutlet weak var sixthDayTemp: UILabel!
    @IBOutlet weak var fifthDayTemp: UILabel!
    @IBOutlet weak var fourthDayTemp: UILabel!
    @IBOutlet weak var thirdDayTemp: UILabel!
    @IBOutlet weak var secondDayTemp: UILabel!
    @IBOutlet weak var firstDayTemp: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var currentDayImgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.alpha = 0.7
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateUI), name: "downloadFinished", object:nil)
        location.downloadCurrentWeatherInfoForZip(zip)
    
    }
    

    
    func updateUI(noti: NSNotification){
        dayArray = (noti.object as? [DayForecast])!
        performSelectorOnMainThread(#selector(updateUIOnMainThread), withObject: nil, waitUntilDone: true)
    }
    
    func updateUIOnMainThread(){
        locationNameLbl.text = location.locationName
        currentTempLbl.text = location.temperature
        maxTempLbl.text = "Max: \(location.maxTemp) Min: \(location.minTemp)"
        currentTimeLbl.text = location.today
        firstDatLbl.text = dayArray[1].day
        secondDayLbl.text = dayArray[2].day
        thirdDayLbl.text = dayArray[3].day
        fourthDayLbl.text = dayArray[4].day
        fifthDayLbl.text = dayArray[5].day
        windSpeedLbl.text = location.speed
        sunsetLbl.text = location.sunset
        firstDayTemp.text = "\(dayArray[1].maxTemp)° / \(dayArray[1].minTemp)°"
        secondDayTemp.text = "\(dayArray[2].maxTemp)° / \(dayArray[2].minTemp)°"
        thirdDayTemp.text = "\(dayArray[3].maxTemp)° / \(dayArray[3].minTemp)°"
        fourthDayTemp.text = "\(dayArray[4].maxTemp)° / \(dayArray[4].minTemp)°"
        fifthDayTemp.text = "\(dayArray[5].maxTemp)° / \(dayArray[5].minTemp)°"
        sixthDayTemp.text = "\(dayArray[6].maxTemp)° / \(dayArray[6].minTemp)°"
        
        
        if let img = UIImage(named: location.desc){
            currentDayImgView.image = img
        }
        
        if let image = UIImage(named: dayArray[1].weatherIcon){
            firstDayImgView.image = image
        }
        
        if let image2 = UIImage(named: dayArray[2].weatherIcon){
            secondDayImgView.image = image2
        }
        
        if let image3 = UIImage(named: dayArray[3].weatherIcon){
            thirdDayImgView.image = image3
        }
        
        if let image4 = UIImage(named: dayArray[4].weatherIcon){
            fourtDayImgView.image = image4
        }
        
        if let image5 = UIImage(named: dayArray[5].weatherIcon){
            fifthDayImgView.image = image5
        }
        
        if let image6 = UIImage(named: dayArray[6].weatherIcon){
            fifthDayImgView.image = image6
        }
       
        
        
        
        

    }

    @IBAction func menuButtonPressed(sender: AnyObject) {
        if sideViewTrailingContraint.constant == -70{
            sideViewTrailingContraint.constant = 0
//            self.view.frame = CGRectMake((self.view.frame.origin.x - 70), self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.height)
        }else{
            sideViewTrailingContraint.constant = -70
//            self.view.frame = CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.height)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    @IBAction func hideButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

