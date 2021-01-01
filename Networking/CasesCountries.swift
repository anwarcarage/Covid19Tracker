//
//  CasesCountries.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/29/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

//Mark: - Welcome
struct CaseCountries: Decodable {
    var data: DataClass
}

//Mark: - DataClasss
struct DataClass: Decodable {
    var timeline: [Timeline]
}

//Mark: - [Timeline]
struct Timeline: Decodable {
    var date: String
    var deaths: Int?
    var confirmed: Int?
    var active: Int?
    var recovered: Int?
    var newConfirmed: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case deaths
        case confirmed
        case active
        case recovered
        case newConfirmed = "new_confirmed"
    }
}

extension Timeline: CountriesDisplayable, DailyDisplayable {
    var countryDeaths: Int {
        deaths ?? 0
    }
    var countryTotal: Int {
        confirmed ?? 0
    }
    var countryActive: Int {
        active ?? 0
    }
    var countryRecovered: Int {
        recovered ?? 0
    }
    var dailyConfirmed: Int {
        newConfirmed ?? 0
    }
    var dailyDate: String {
        date
    }
}
