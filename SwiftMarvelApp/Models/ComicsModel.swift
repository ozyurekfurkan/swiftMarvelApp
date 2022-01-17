//
//  ComicsModel.swift
//  SwiftMarvelApp
//
//  Created by Furkan Özyürek on 16.01.2022.
//

import Foundation
import ObjectMapper

struct ComicsModel : Mappable {
    var name : String?
    var comicHttp : String?
    init?(map : Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        comicHttp <- map["resourceURI"]
    }
}
