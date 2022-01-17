//
//  CharacterModel.swift
//  SwiftMarvelApp
//
//  Created by Furkan Özyürek on 16.01.2022.
//

import Foundation
import ObjectMapper

struct CharacterModel : Mappable {
    var characterName : String?
    var characterImage : String?
    var characterImageExtesion : String?
    var characterDescription : String?
    var comicList : [ComicsModel]?
    
    init?(map : Map) {
        
    }
    
    mutating func mapping(map: Map) {
        characterName <- map["name"]
        characterImage <- map["thumbnail.path"]
        characterImageExtesion <- map["thumbnail.extension"]
        comicList <- map["comics.items"]
        characterDescription <- map["description"]
    }
    
}
