//
//  MathGameHistory.swift
//  Doodle
//
//  Created by William Huang on 3/13/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation
import CoreData

class MathGameHistory: NSManagedObject {

    @NSManaged var timeStamp: NSDate
    @NSManaged var levelsCompleted: NSNumber

}
