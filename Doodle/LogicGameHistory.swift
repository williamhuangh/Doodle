//
//  LogicGameHistory.swift
//  Doodle
//
//  Created by William Huang on 3/13/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation
import CoreData

class LogicGameHistory: NSManagedObject {

    @NSManaged var levelsCompleted: NSNumber
    @NSManaged var timeStamp: NSDate

}
