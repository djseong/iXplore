//
//  Journal.swift
//  iXplore
//
//  Created by Daniel Seong on 7/11/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import MapKit

class Entry: NSObject, MKAnnotation {
    var title: String? = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var notes: [String] = []
    var date: NSDate = NSDate()
}