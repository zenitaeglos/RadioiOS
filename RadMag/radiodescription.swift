//
//  radiodescription.swift
//  RadMag
//
//  Created by Alejandro Martinez Montero on 16/03/2019.
//  Copyright © 2019 Alejandro Martinez Montero. All rights reserved.
//

import UIKit


class RadioDescription {
    var name: String
    var url: String
    var favicon: String
    var homepage: String
    var country: String
    
    init(name: String, url: String, favicon: String, homepage: String, country: String) {
        self.name = name
        self.url = url
        self.favicon = favicon
        self.homepage = homepage
        self.country = country
    }
}
