//
//  Articles.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import UIKit
import ObjectMapper

class Articles: Mappable {
    
    var source: String?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    var imageURL: URL? {
        return URL(string: urlToImage ?? "")
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
    }
    
}

class Source: Mappable {
    
    var id: String?
    var name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}


class FilterModel {
    
    var name: String?
    var isSelected: Bool = false
    
    init(name: String, isSelected: Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
}
