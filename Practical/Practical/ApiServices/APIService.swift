//
//  APIService.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import Foundation
import Moya

enum ArticleServices {
    case getArticleList(apiKey: String, source: String)
}

extension ArticleServices: TargetType {
    var baseURL: URL {
        switch self {
        
        default: return URL(string: "https://newsapi.org/v2/")!
        }
    }
    
    var path: String {
        switch self {
        case .getArticleList: return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch  self {
        case .getArticleList: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch  self {
        case .getArticleList(let apiKey, let source):
            return Task.requestParameters(parameters: ["sources": source, "apiKey": apiKey], encoding: URLEncoding(destination: .queryString))
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
    
}
