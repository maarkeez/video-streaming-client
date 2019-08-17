//
//  Serie.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 15/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

class Serie {
    
    let displayImage : UIImage
    let name : String
    let seasons : [Season]
    
    init(displayImage : UIImage, name: String, seasons : [Season]){
        self.displayImage = displayImage
        self.name = name
        self.seasons = seasons
    }
    
}
