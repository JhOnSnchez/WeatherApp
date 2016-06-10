//
//  SearchVC.swift
//  WeatherApp
//
//  Created by Jhonathan Sanchez on 6/9/16.
//  Copyright © 2016 Jhonathan Sanchez. All rights reserved.
//

import UIKit
import CoreLocation

class SearchVC: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate  {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var zipTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        zipTextField.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         view.frame = CGRectMake(self.view.bounds.origin.x, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        view.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y - 250, self.view.bounds.size.width, self.view.bounds.size.height)
    }
    

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print(currentLocation.description)
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placeMarks, error) in
            if error == nil{
                if let place = placeMarks?.first{
                    if let zip = place.postalCode {
                        self.locationManager.stopUpdatingLocation()
                        self.callSegueWithZip(zip)
                    }
                    
                }
            }
        }
        
        locationManager.stopUpdatingLocation()
    }

    
    
    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
            
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
  
    @IBAction func locationButtonPressed(sender: AnyObject) {
        checkLocationAuthStatus()
        
    }

    
    @IBAction func showButtonPressed(sender: AnyObject) {
        
        if let zip = zipTextField.text where !zip.isEmpty{
            callSegueWithZip(zip)
           
        }else{
            let color = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1.0)
            zipTextField.layer.borderColor = color.CGColor
            zipTextField.layer.borderWidth = 1
        }
        
        
    }
    
    func callSegueWithZip(zip: String){
        performSegueWithIdentifier("showDetails", sender: zip)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails"{
            if let detailVC = segue.destinationViewController as? DetailsVC{
                if let zip = sender as? String{
                    
                    detailVC.zip = zip
                }
            }
        }
    }

    
    
}
