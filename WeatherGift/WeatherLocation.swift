//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by user150978 on 3/18/19.
//  Copyright © 2019 Tion. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation{
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + coordinates

        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                if let temperature = json["currently"]["temperature"].double{
                    print("*** temp inside = \(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("could not return a temperature")
                }
                if let summary = json["daily"]["summary"].string {
                    self.currentSummary = summary
                } else {
                    print("Could not return a summary")
                }
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                } else {
                    print("Could not return a icon")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
