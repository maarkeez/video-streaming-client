//
//  SerieClient.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 15/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class SerieClient {
    
    private init(){}
    
    public static func singleton() -> SerieClient {
        return SerieClient()
    }

    func findAll() -> Promise<[Serie]> {
        
        return Promise { seal in
            Alamofire.request(getBaseUrl() + "/vss/api/serie", method: .get).responseJSON { response in
                switch response.result {
                case .success(let json):
                    guard let json = json  as? [[String: Any]] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    
                    seal.fulfill(self.toSeries(from: json))
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    private func toSeries(from list: [[String: Any]]) -> [Serie] {
        var series : [Serie] = []
        
        for item in list {
            series.append(self.toSerie(from: item))
        }
        return series
    }
    
    private func toSerie(from item: [String: Any]) -> Serie {
        let hasDisplayImageUrl = item["hasDisplayImageUrl"] as! Bool
        let displayImageUrl = item["displayImageUrl"] as! String
        let name = item["name"] as! String
        var image = #imageLiteral(resourceName: "no_image_available")
        
        if(hasDisplayImageUrl){
            let displayImageCompleteUrl = getBaseUrl() + "/" + displayImageUrl
            print("Searching for image: " + displayImageCompleteUrl)
            
            if let displayImageData = try? Data(contentsOf: URL(string: displayImageCompleteUrl)!) {
                print("Imagen found!")
                image = UIImage(data: displayImageData)!
            }
        }
        
        return Serie(displayImage: image, name: name)
    }
    
    private func getBaseUrl() -> String {
        return "http://10.10.1.117:8080"
    }
    
}
