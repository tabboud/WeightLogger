//
//  WeightLogTableViewController.swift
//  WeightLogger
//
//  Created by Tony on 6/19/14.
//  Copyright (c) 2014 Abbouds Corner. All rights reserved.
//

import UIKit
import CoreData


class WeightLogTableViewController: UITableViewController {
    var totalEntries: Int = 0
    
    @IBOutlet var tblLog : UITableView?
    
    @IBAction func btnClearLog(sender : AnyObject) {
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        let results: NSArray = try! context.executeFetchRequest(request)
        
        for weightEntry: AnyObject in results{
            context.deleteObject(weightEntry as! NSManagedObject)
        }
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = 0
        tblLog?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        
        totalEntries = context.countForFetchRequest(request, error: nil) as Int!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// #pragma mark - UITableViewDataSource Methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.executeFetchRequest(request)) as NSArray!
        
        //get contents and put into cell
        let thisWeight: UserWeights = results[indexPath.row] as! UserWeights
        cell.textLabel?.text = thisWeight.weight + " " + thisWeight.units
        cell.detailTextLabel?.text = thisWeight.date
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //delete object from entity, remove from list
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.executeFetchRequest(request)) as NSArray!
        
        //Get value that is being deeleted
        let tmpObject: NSManagedObject = results[indexPath.row] as! NSManagedObject
        let delWeight = tmpObject.valueForKey("weight") as? String
        print("Deleted Weight: \(delWeight)")
        
        context.deleteObject(results[indexPath.row] as! NSManagedObject)
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = totalEntries - 1
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        print("Done")
    }
    
}
