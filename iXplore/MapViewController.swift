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
        EntryController.sharedInstance.addEntries()
        
        // Navigation bar
        navigationItem.title = "iXplore"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(AddEntry))
        
        // Delegates
        mapview.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        
        
        
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
        var reusableCell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if reusableCell == nil {
            reusableCell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        
            
        }
        reusableCell!.textLabel?.text = EntryController.sharedInstance.getEntries()[indexPath.row].title!
        return reusableCell!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
