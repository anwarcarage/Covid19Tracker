//
//  UnitedStates.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/24/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - Welcome
struct CaseStates: Decodable {
    var positive: Int
    var death: Int
    var recovered: Int
    
    enum CodingKeys: String, CodingKey {
        case positive
        case death
        case recovered
    }
}

extension CaseStates: StatesDisplayable {
    var statesTotal: Int {
        positive
    }
    var statesDeaths: Int {
        death
    }
    var statesRecovered: Int {
        recovered
    }
}
