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
    
    var publishedDate: String {
        let date = publishedAt?.toDate(format: DateFormate.server)?.toString(formateType: .converted)
        return date ?? ""
    }
    
    init() {}
    
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


enum DateFormate: String {
    case yyyy_MM_dd_T_HH_MM_SS_XXX = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    case yyyy_MM_dd_T_HH_MM_SS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case server = "yyyy-MM-dd'T'HH:mm:ssZ"
    case converted = "dd MMM yyyy"
}

extension String {
    //Convert timezone string to NSTimeZone
    func toDate(format: DateFormate = .yyyy_MM_dd_T_HH_MM_SS_Z, timZone: TimeZone? = TimeZone(abbreviation: "UTC")) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timZone
        if format == .yyyy_MM_dd_T_HH_MM_SS_Z {
            if let formattedDate = dateFormatter.date(from: self) {
                return formattedDate
            } else {
                dateFormatter.dateFormat = DateFormate.yyyy_MM_dd_T_HH_MM_SS_Z.rawValue
                return dateFormatter.date(from: self)
            }
        }
        return dateFormatter.date(from: self)
    }
}
extension Date {
    func toString(formateType type: DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}
