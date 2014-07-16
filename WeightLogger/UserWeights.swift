//
//  UserWeights.swift
//  WeightLogger
//
//  Created by Tony on 6/19/14.
//  Copyright (c) 2014 Abbouds Corner. All rights reserved.
//

import UIKit
import CoreData

@objc(UserWeights)
class UserWeights: NSManagedObject {
    
    @NSManaged var weight: String
    @NSManaged var date: String
    @NSManaged var units: String
    
}
