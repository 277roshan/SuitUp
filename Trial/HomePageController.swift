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
    var mPrice: Int?
    var mImage: UIImage?
    
    
    
    init(name:String, category:String, size:String, price:Int, image:UIImage){
        
        self.mName = name;
        self.mCategory = category;
        self.mSize = size;
        self.mPrice = price;
        self.mImage = image
        
        super.init();
        
    }
    
    override init(){
        
        super.init();
    }
    

    
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
            KCSStoreKeyCollectionTemplateClass : Cloths.self
            ])
        
        let cloth = Cloths()
        cloth.mPrice = priceOutlet.text as! Int
        cloth.mSize = sizeOutlet.text
        cloth.mCategory = categoryOutlet.text
        cloth.mImage = imageView.image
        print(cloth.mImage)
        
        someImageStore.saveObject(cloth, withCompletionBlock: {

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


