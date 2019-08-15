//
//  SeriesService.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 15/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import PromiseKit

class SerieSerivce {
    
    private init(){
        
    }
    
    static func singleton() -> SerieSerivce {
        return SerieSerivce()
    }
    
    func findAll() -> Promise<[Serie]> {
        return SerieClient.singleton().findAll()
    }
    
}
