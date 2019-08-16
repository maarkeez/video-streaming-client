//
//  Episode.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 16/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class Episode {
    
    let title : String
    let videoLink : String
    
    init(title : String, videoLink: String){
        self.title = title
        self.videoLink = videoLink
    }
    
}
