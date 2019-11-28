//
//  CoreDataService
//  WeatherPlaces
//
//  Created by Emil Iakoupov on 2019-11-25.
//  Copyright © 2019 Emil Iakoupov. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    func saveCityLocation(location: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        let locationEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        locationEntity.setValue(location, forKey: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getSavedLocations() -> NSArray {
        var locations: NSArray = NSArray()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return locations
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        
        do {
            locations = try managedContext.fetch(fetchRequest) as NSArray
        } catch let error as NSError {
            print(error)
        }
        
        locations = locations.map({ (data) -> String in
            let managedObj = data as! NSManagedObject
            return managedObj.value(forKey: "name") as! String
        }) as NSArray
        
        return locations
    }
}
