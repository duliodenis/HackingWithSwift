//
//  Person.swift
//  NamesToFaces
//
//  Created by Dulio Denis on 1/21/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}
