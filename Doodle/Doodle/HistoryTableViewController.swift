//
//  HistoryTableViewController.swift
//  Doodle
//
//  Created by William Huang on 3/7/15.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var mathFetchedResultController = NSFetchedResultsController()
    var memoryFetchedResultController = NSFetchedResultsController()
    var logicFetchedResultController = NSFetchedResultsController()
    var fetchedResultControllers = [NSFetchedResultsController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mathFetchedResultController = getMathFetchedResultController()
        mathFetchedResultController.delegate = self
        mathFetchedResultController.performFetch(nil)
        
        memoryFetchedResultController = getMemoryFetchedResultController()
        memoryFetchedResultController.delegate = self
        memoryFetchedResultController.performFetch(nil)
        
        logicFetchedResultController = getLogicFetchedResultController()
        logicFetchedResultController.delegate = self
        logicFetchedResultController.performFetch(nil)
        
        fetchedResultControllers.append(self.logicFetchedResultController)
        fetchedResultControllers.append(self.memoryFetchedResultController)
        fetchedResultControllers.append(self.mathFetchedResultController)
    }
    
    func getMathFetchedResultController() -> NSFetchedResultsController {
        mathFetchedResultController = NSFetchedResultsController(fetchRequest: taskMathFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return mathFetchedResultController
    }
    
    func taskMathFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "MathGameHistory")
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getMemoryFetchedResultController() -> NSFetchedResultsController {
        memoryFetchedResultController = NSFetchedResultsController(fetchRequest: taskMemoryFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return memoryFetchedResultController
    }
    
    func taskMemoryFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "MemoryGameHistory")
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getLogicFetchedResultController() -> NSFetchedResultsController {
        logicFetchedResultController = NSFetchedResultsController(fetchRequest: taskLogicFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return logicFetchedResultController
    }
    
    func taskLogicFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "LogicGameHistory")
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultControllers.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            if let scn = fetchedResultControllers[0].sections{
                return scn[0].numberOfObjects
            }
        case 1:
            if let scn = fetchedResultControllers[1].sections{
                return scn[0].numberOfObjects
            }
        case 2:
            if let scn = fetchedResultControllers[2].sections{
                return scn[0].numberOfObjects
            }
        default:
            return 0
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Logic Game"
        case 1:
            return "Memory Game"
        case 2:
            return "Math Game"
        default:
            return "Logic Game"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as UITableViewCell
        switch indexPath.section{
        case 0:
            let logicGameHistory = fetchedResultControllers[0].objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) as LogicGameHistory
            cell.textLabel?.text = "Level: \(logicGameHistory.levelsCompleted), \(logicGameHistory.timeStamp.description)"
        case 1:
            let memoryGameHistory = fetchedResultControllers[1].objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) as MemoryGameHistory
            cell.textLabel?.text = "Level: \(memoryGameHistory.levelsCompleted), \(memoryGameHistory.timeStamp.description)"
        case 2:
            let mathGameHistory = fetchedResultControllers[2].objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) as MathGameHistory
            cell.textLabel?.text = "Level: \(mathGameHistory.levelsCompleted), \(mathGameHistory.timeStamp.description)"
        default:
            let logicGameHistory = fetchedResultControllers[0].objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) as LogicGameHistory
            cell.textLabel?.text = "Level: \(logicGameHistory.levelsCompleted), \(logicGameHistory.timeStamp.description)"
        }
        
        return cell
    }
    
    
    @IBAction func deleteAllObjects(sender: UIBarButtonItem) {
        if let arr = logicFetchedResultController.fetchedObjects as? [LogicGameHistory]{
            for lgh in arr {
                managedObjectContext?.deleteObject(lgh)
                managedObjectContext?.save(nil)
            }
        }
        
        if let arr = memoryFetchedResultController.fetchedObjects as? [MemoryGameHistory]{
            for mgh in arr {
                managedObjectContext?.deleteObject(mgh)
                managedObjectContext?.save(nil)
            }
        }
        
        if let arr = mathFetchedResultController.fetchedObjects as? [MathGameHistory]{
            for mgh in arr {
                managedObjectContext?.deleteObject(mgh)
                managedObjectContext?.save(nil)
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
}
