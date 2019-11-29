//
//  WeatherDetailsViewController.swift
//  WeatherPlaces
//
//  Created by Emil Iakoupov on 2019-11-28.
//  Copyright © 2019 Emil Iakoupov. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    var location: String = ""
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var temperture: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    var service: RequesterService = RequesterService()
    
    func weatherDataHandler(result: NSDictionary) {
        // show error if there is an error response
        DispatchQueue.main.async {
            let main: NSDictionary = result.value(forKey: "main") as! NSDictionary
            self.temperture.text = (main.value(forKey: "temp") as! NSNumber).stringValue
            self.humidity.text = (main.value(forKey: "humidity") as! NSNumber).stringValue
        }
    }
    func weatherDataErrorHandler() {
        // show error if there is an error response
        DispatchQueue.main.async {
            self.errorLabel.text = "Oops no data found!"
            self.temperture.text = ":("
            self.humidity.text = ":("
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        temperture.text = "Loading..."
        humidity.text = "Loading..."
        service.getWeatherData(name: location, completion: weatherDataHandler, onError: weatherDataErrorHandler)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using
        // Pass the selected object to the new view controller.
    }
    

}
