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
    var date: Int?
    var positiveIncrease: Int?
    var deathIncrease: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case positiveIncrease
        case deathIncrease
    }
}

extension Cases: CasesDisplayable {
    var casesDate: Int {
        date ?? 0
    }
    var casesPositive: Int {
        positiveIncrease ?? 0
    }
    var casesDeaths: Int {
        deathIncrease ?? 0
    }
}
