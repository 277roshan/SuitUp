//
//  MainDisplayPage.swift
//  Trial
//
//  Created by Roshan Thapaliya on 3/25/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

import UIKit

class MainDisplayController: UITableViewController {




    @IBAction func AddDressAction(sender: AnyObject) {
        self.performSegueWithIdentifier("addDress", sender: self)
        
    }

    
    var valueFromQuery: [Cloths] = []
    var clotharray: [Cloths] = [Cloths]();
  // var item1: Cloths = Cloths(name: "Preksha", category: "Yehi", size: "S", price:12, image: UIImage(named: "Image")!);
    
    
    
    
   
    
    
    override func viewDidLoad() {
        
        let collection = KCSCollection(fromString: "Cloths", ofClass: Cloths.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "price", withExactMatchForValue: "34"),
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    //NSLog("successful reload: %@", objectsOrNil as! NSObject) // event updated
                    
                    self.valueFromQuery = objectsOrNil as! NSObject as! [Cloths]
                    //print(self.valueFromQuery)
                    
                    
                    //print(self.valueFromQuery)
                    
                    self.tableView.reloadData()
                    
                    
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
                
                
                
            },
            withProgressBlock: nil
        )

        
        
        
        
        
        print (UIImage(named: "Image"));
        
        //clotharray.append(item1);
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.valueFromQuery.count;
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell;
        
        print("---------------------------")
       
       
        
        
        var cloth = valueFromQuery[indexPath.row];
        print(cloth.mPrice)
        
        

        
        
        
        
        return cell;
    }
}

