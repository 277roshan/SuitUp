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

        
        //clotharray.append(item1);
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let collection = KCSCollection(fromString: "Cloths", ofClass: Cloths.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        store.queryWithQuery(
            KCSQuery(onField: "price", usingConditional: KCSQueryConditional.KCSGreaterThan, forValue:0),
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
        super.viewWillAppear(true)
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
      
        
        
        var cloth = valueFromQuery[indexPath.row];
        
        cell.mImageView.image = cloth.mImage
        cell.mPrice.text = String(cloth.mPrice!)
        cell.mCategory.text = cloth.mCategory
        cell.mSize.text = cloth.mSize
        print(cloth.mImage)
        
//        KCSFileStore.downloadData(
//            cloth.mImage,
//            completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
//                if error == nil {
//                    let file = downloadedResources[0] as! KCSFile
//                    let fileData = file.data
//                    var outputObject: NSObject! = nil
//                    if file.mimeType.hasPrefix("text") {
//                        outputObject = NSString(data: fileData, encoding: NSUTF8StringEncoding)
//                    } else if file.mimeType.hasPrefix("image") {
//                        outputObject = UIImage(data: fileData)
//                    }
//                    NSLog("downloaded: %@", outputObject)
//                } else {
//                    NSLog("Got an error: %@", error)
//                }
//            },
//            progressBlock: nil
//        )
//        

        
        return cell;
    }
}

