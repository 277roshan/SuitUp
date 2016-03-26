//
//  HomePageController.swift
//  Trial
//
//  Created by Roshan Thapaliya on 3/22/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

import UIKit


class Cloths: NSObject {
    var mName: String?
    var mCategory: String?
    var mSize: String?
    var mPrice: NSNumber?
    var mImage: UIImage?
    var entityId: String?
    
 override init(){
        
        super.init();
    }
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId": KCSEntityKeyId,
            "mName" : "name",
            "mPrice" : "price",
            "mSize" : "size",
            "mCategory" : "category",
            "mImage" : "mImage",
        
        ]
    }
    
    override class func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "mImage" : KCSFileStoreCollectionName,
            
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["mImage"]
    }
}


class HomePageController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageOutlet: UIImageView!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var priceOutlet: UITextField!
    
    
    @IBOutlet var sizeOutlet: UITextField!
    
    
    @IBOutlet var categoryOutlet: UITextField!
    
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
//        store.loadObjectWithID(
//            "56f623061b6974a80218d46d",
//            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
//                if errorOrNil == nil {
//                    NSLog("successful reload: %@", objectsOrNil[0] as! NSObject) // event updated
//                    
//                    print(objectsOrNil[0].mSize)
//                    
//                    
//                } else {
//                    NSLog("error occurred: %@", errorOrNil)
//                }
//            },
//            withProgressBlock: nil
//        )
        
        
        imagePicker.delegate = self
        print(KCSUser.activeUser().username)
    }
    
    
    @IBAction func saveImageWithObject(sender: AnyObject) {
        
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([

            KCSStoreKeyCollectionName: "Cloths",
            KCSStoreKeyCollectionTemplateClass : Cloths.self
            ])
        
        
        let data = UIImageJPEGRepresentation(imageView.image!, 0.9)
        KCSFileStore.uploadData(data, options: nil, completionBlock: {(uploadInfo: KCSFile!, error: NSError!) -> Void in
            print ("hello")
            print("file id is\(uploadInfo.fileId)");
        
            
        
        let cloth = Cloths()
        cloth.mPrice = Int(self.priceOutlet.text!)
        cloth.mSize = self.sizeOutlet.text
        cloth.mCategory = self.categoryOutlet.text
        cloth.mImage = self.imageView.image!
            cloth.mName = KCSUser.activeUser().username;
        //print(cloth.mImage)
        
     
        
        
        
        someImageStore.saveObject(cloth, withCompletionBlock: {

            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            
            
            
            if errorOrNil != nil {
                //save failed
                NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
            } else {
                //save was successful
                NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
            }
            },
            withProgressBlock: nil
            )
        
            
            }, progressBlock: nil)
    }
   
    
    @IBAction func TakePhotoButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @IBAction func loadImageButtonTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}


