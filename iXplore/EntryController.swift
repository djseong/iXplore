//
//  EntryController.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import MapKit

class EntryController {
    static var sharedInstance = EntryController()
    var entries: [Entry] = []
    
    /*func addEntries() {
        let spot = Entry()
        spot.title = "test 1"
        spot.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        
        let spot2 = Entry()
        spot2.title = "test 2"
        spot2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        
        let spot3 = Entry()
        spot3.title = "test 3"
        spot3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        
        entries = [spot, spot2, spot3]

    }*/
    
    func getEntries() -> [Entry] {
        // Set up file manager
        let manager = NSFileManager.defaultManager()
        let documents = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        // Make URL to documents folder
        let fileURL = documents.URLByAppendingPathComponent("entries.txt")
            
        if let entryList = NSKeyedUnarchiver.unarchiveObjectWithFile(fileURL.path!) as? [Entry]
        {
            self.entries = entryList
        }
        return entries
    }
}