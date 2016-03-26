//
//  HomePageController.swift
//  Trial
//
//  Created by Roshan Thapaliya on 3/22/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

import UIKit

class Dress: NSObject {
    var price: String?
    var size: String?
    var category: String?
    var someId: String?
    var someImage: UIImage?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "someId" : KCSEntityKeyId,
            "price" : "price",
            "size" : "size",
            "category" : "category",
            "someImage" : "someImage",
        ]
    }
    
    override class func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "someImage" : KCSFileStoreCollectionName,
            
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["someImage"]
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
        
        

        imagePicker.delegate = self
        print(KCSUser.activeUser().username)
    }
    
    
    @IBAction func saveImageWithObject(sender: AnyObject) {
        
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Dress",
            KCSStoreKeyCollectionTemplateClass : Dress.self
            ])
        
        let someImage = Dress()
        someImage.price = priceOutlet.text
        someImage.size = sizeOutlet.text
        someImage.category = categoryOutlet.text
        someImage.someImage = imageView.image
        print(someImage.someImage)
        
        someImageStore.saveObject(someImage, withCompletionBlock: {
            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            
            }, withProgressBlock: nil)
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


