//
//  CountriesDisplayable.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/29/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

protocol CountriesDisplayable {
    var countryDeaths: Int { get }
    var countryTotal: Int { get }
    var countryActive: Int { get }
    var countryRecovered: Int { get }
}
