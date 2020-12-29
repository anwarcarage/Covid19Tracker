//
//  Cases.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/21/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - Welcome
struct Cases: Decodable {
    var positive: Int?
    var death: Int?
    var recovered: Int?
    
    enum CodingKeys: String, CodingKey {
        case positive
        case death
        case recovered
    }
}

extension Cases: CasesDisplayable {
    var casesTotal: Int {
        positive ?? 0
    }
    var casesDeaths: Int {
        death ?? 0
    }
    var casesRecovered: Int {
        recovered ?? 0
    }
}
