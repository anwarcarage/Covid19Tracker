//
//  ThirdViewControllerData.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/14/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - Welcome
struct News: Decodable {
    var status: String
    var copyright: String
    var response: Response
}

//MARK: - Response
struct Response: Decodable {
    var docs: [Doc]
}

//MARK: - Doc
struct Doc: Decodable {
    var abstract: String
    var webUrl: String
    var snippet: String
    var leadParagraph: String
    var source: String
    
    enum CodingKeys: String, CodingKey {
        case abstract
        case webUrl = "web_url"
        case snippet
        case leadParagraph = "lead_paragraph"
        case source
    }
}

extension Doc: Displayable {
    var newsTitle: String {
        abstract
    }
    
    var newsBody: String {
        leadParagraph
    }
    
    var newsUrlLink: String {
        webUrl
    }
    
    var newsSource: String {
        source
    }
}


