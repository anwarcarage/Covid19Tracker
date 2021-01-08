//
//  StatesDisplayable.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/24/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

protocol StatesDisplayable {
    var statesTotal: Int? { get }
    var statesDeaths: Int? { get }
    var statesRecovered: Int? { get }
}
