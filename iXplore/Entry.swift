//
//  Journal.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import MapKit

class Entry: NSObject, MKAnnotation, NSCoding {
    var title: String? = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var notes: [String] = []
    var date: NSDate = NSDate()
    var image: UIImage?
    
    init(title: String, coordinate: CLLocationCoordinate2D, notes: [String], date: NSDate, image: UIImage?) {
        self.title = title
        self.coordinate = coordinate
        self.notes = notes
        self.date = date
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        title = (coder.decodeObjectForKey("title") as? String) ?? ""
        coordinate = CLLocationCoordinate2D(latitude: coder.decodeObjectForKey("latitude") as? CLLocationDegrees ?? CLLocationDegrees(), longitude: coder.decodeObjectForKey("longitude") as? CLLocationDegrees ?? CLLocationDegrees())
        notes = (coder.decodeObjectForKey("notes") as? [String]) ?? []
        date = (coder.decodeObjectForKey("date") as? NSDate) ?? NSDate()
        image = (coder.decodeObjectForKey("image") as? UIImage) ?? nil
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(coordinate.latitude, forKey: "latitude")
        aCoder.encodeObject(coordinate.longitude, forKey: "longitude")
        aCoder.encodeObject(notes, forKey: "notes")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(image, forKey: "image")

    }
    

    
}