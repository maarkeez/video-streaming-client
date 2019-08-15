//
//  ApiSerie.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 15/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class ApiSerie {
    
    private let name: String;
    private let folderName: String;
    private let hasDisplayImageUrl: Bool;
    private let displayImageUrl: String;
    
    public init(name: String,
                folderName: String,
                hasDisplayImageUrl: Bool,
                displayImageUrl: String){
        self.name = name
        self.folderName = folderName
        self.hasDisplayImageUrl = hasDisplayImageUrl
        self.displayImageUrl = displayImageUrl
    }
    
    
}
