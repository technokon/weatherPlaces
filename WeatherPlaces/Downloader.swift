//
//  Downloader.swift
//  YahooData
//
//  Created by Emil Iakoupov on 2019-11-07.
//  Copyright © 2019 Emil Iakoupov. All rights reserved.
//

import Foundation

protocol downloaderDelegate {
    func downloaderDidFinishWithResult(data : NSArray)
}
class Downloader {
    
    var delegate : downloaderDelegate? = nil
    
    func searchForResult(test : String) {
        // finish networking task
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=demo"
        let urlObj = URL(string: urlString)
        if let correctUrlObject = urlObj {
            _ = URLSessionConfiguration.default
            let session = URLSession(configuration: .default)
            session.dataTask(with: correctUrlObject, completionHandler: { (data, response, error) in
                if let dataFromTask = data {
                    var stringFromData = String(data: dataFromTask, encoding: String.Encoding.utf8)
                    let jsonObject = JSONSerialization.jsonObject(with: <#T##Data#>, options: <#T##JSONSerialization.ReadingOptions#>)
                    print(stringFromData)
                }
            }).resume()
        }
    }
}
