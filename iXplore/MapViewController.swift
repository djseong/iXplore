//
//  MapViewController.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dummy data
        //EntryController.sharedInstance.addEntries()
        
        // Navigation bar
        navigationItem.title = "iXplore"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(AddEntry))
        
        // Delegates
        mapview.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
        // Register custom cell
        tableview.registerNib(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellidentifier")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        self.tableview.reloadData()
        
        // Initialize map
        let location = CLLocationCoordinate2D(latitude: -33.906764, longitude: 18.4164983)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: true)
        mapview.zoomEnabled = true
        mapview.addAnnotations(EntryController.sharedInstance.getEntries())
    }
    
    // Go to AddEntry view 
    func AddEntry() {
        let addentryviewcontroller = AddEntryViewController(nibName: "AddEntryViewController", bundle: nil)
        self.presentViewController(addentryviewcontroller, animated: true, completion: nil)
    }
    
    // Map functions

    
    // Tableview functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.getEntries().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellidentifier"
        let reusableCell = tableView.dequeueReusableCellWithIdentifier(identifier) as! TableViewCell
        
        // Format date
        let date = EntryController.sharedInstance.getEntries()[indexPath.row].date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)

        reusableCell.titleLabel.text = EntryController.sharedInstance.getEntries()[indexPath.row].title!
        reusableCell.dateLabel.text = String(components.month) + "/" + String(components.day) + "/" + String(components.year)
        //reusableCell.imageview = UIImageView(image: EntryController.sharedInstance.getEntries()[indexPath.row].image)
        reusableCell.imageview.image = EntryController.sharedInstance.getEntries()[indexPath.row].image
        return reusableCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = EntryController.sharedInstance.getEntries()[indexPath.row].coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: true)

    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, path) in
            print(path.row)
            var removeEntry = EntryController.sharedInstance.entries.removeAtIndex(path.row)
            //self.tableview.reloadData()
            print(removeEntry.title)
           // print(EntryController.sharedInstance.entries[path.row].title)
        })
        tableview.reloadData()
        return [remove]
    }
    

}
