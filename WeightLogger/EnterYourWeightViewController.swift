//
//  EnterYourWeightViewController.swift
//  WeightLogger
//
//  Created by Tony on 6/19/14.
//  Copyright (c) 2014 Abbouds Corner. All rights reserved.
//

import UIKit
import CoreData


class EnterYourWeightViewController: UIViewController {
    
    
    @IBOutlet var txtWeight : UITextField!
    @IBOutlet var units : UISwitch!
    
    @IBAction func btnSavePressed(sender : AnyObject) {
        
        
        if(!txtWeight.text.isEmpty){
            //save data
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            
            let ent = NSEntityDescription.entityForName("UserWeights", inManagedObjectContext: context)!
            
            //Instance of our custom class, reference to entity
            var newWeight = UserWeights(entity: ent, insertIntoManagedObjectContext: context)
            
            //Fill in the Core Data
            newWeight.weight = txtWeight.text
            if(units.on){
                newWeight.units = "lbs"
            }else{
                //Switch is off
                newWeight.units = "kgs"
            }
            
            let dateFormatter = NSDateFormatter()
            var curLocale: NSLocale = NSLocale.currentLocale()
            var formatString: NSString = NSDateFormatter.dateFormatFromTemplate("EdMMM h:mm a", options: 0, locale: curLocale)!
            dateFormatter.dateFormat = formatString as String
            newWeight.date = dateFormatter.stringFromDate(NSDate())
            
            context.save(nil)
        }else{
            //User carelessly pressed save button without entering weight.
            var alert:UIAlertController = UIAlertController(title: "No Weight Entered", message: "Enter your weight before pressing save.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(result)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        txtWeight.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
