//
//  DailyDisplayable.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/29/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

protocol DailyDisplayable {
    var dailyConfirmed: Int { get }
    var dailyDate: String { get }
    var dailyDeaths: Int { get }
}
