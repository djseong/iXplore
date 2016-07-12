//
//  AddEntryViewController.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddEntryViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titlefield: UITextField!
    @IBOutlet weak var notesfield: UITextField!
    @IBOutlet weak var latitudefield: UITextField!
    @IBOutlet weak var longitudefield: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    
    // Location manager
    let locationmanager = CLLocationManager()
    
    //Image picker controller
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        locationmanager.delegate = self
        imagePicker.delegate = self
        
        // Ask for location authorization
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
    }
    
    // CLLocation functions
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudefield.text = String(locations.last!.coordinate.latitude)
        longitudefield.text = String(locations.last!.coordinate.longitude)
        locationmanager.stopUpdatingLocation()
    }
    
    // Image Picker functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageview.contentMode = .ScaleAspectFit
            imageview.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // Button Presses
    @IBAction func CancelPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SavePressed(sender: UIButton) {
        
        // Set up file manager
        let manager = NSFileManager.defaultManager()
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        // Make URL to documents folder
        let fileURL = documents.URLByAppendingPathComponent("entries.txt")
        
        // Make new entry and append to list
        print(imageview.image)
        let newEntry = Entry(title: titlefield.text!, coordinate: CLLocationCoordinate2D(latitude: Double(latitudefield.text!)!, longitude: Double(longitudefield.text!)!)
            , notes: [], date: NSDate(), image: imageview.image)
        EntryController.sharedInstance.entries.append(newEntry)
        
        // Archive
        NSKeyedArchiver.archiveRootObject(EntryController.sharedInstance.entries, toFile: fileURL.path!)
        
        
       // EntryController.sharedInstance.entries.append(newEntry)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func LoadPressed(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}
