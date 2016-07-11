//
//  AddEntryViewController.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import MapKit

class AddEntryViewController: UIViewController {
    
    @IBOutlet weak var titlefield: UITextField!
    @IBOutlet weak var notesfield: UITextField!
    @IBOutlet weak var latitudefield: UITextField!
    @IBOutlet weak var longitudefield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Button Presses
    
    @IBAction func CancelPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SavePressed(sender: UIButton) {
        var newEntry = Entry()
        newEntry.title = titlefield.text
        newEntry.coordinate = CLLocationCoordinate2D(latitude: Double(latitudefield.text!)!, longitude: Double(longitudefield.text!)!)
        newEntry.notes = []
        newEntry.date = NSDate()
        
        EntryController.sharedInstance.entries.append(newEntry)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
