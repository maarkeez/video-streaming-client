//
//  SeriesService.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 15/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation

class SerieSerivce {
    
    private init(){
        
    }
    
    static func singleton() -> SerieSerivce {
        return SerieSerivce()
    }
    
    func findAll() -> [Serie] {
        var series : [Serie] = []
        for _ in 0...49 {
            series.append(Serie(displayImage: #imageLiteral(resourceName: "true_blood")))
        }
        
        return series
        
    }
    
    
}
