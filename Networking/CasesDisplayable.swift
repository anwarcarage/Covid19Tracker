//
//  CasesDisplayable.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/21/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

protocol CasesDisplayable {
    var casesTotal: Int { get }
    var casesDeaths: Int { get }
    var casesRecovered: Int { get }
}


