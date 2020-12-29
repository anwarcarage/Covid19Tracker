//
//  Displayable.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/15/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import Alamofire

protocol Displayable {
    var newsTitle : String { get }
    var newsBody : String { get }
    var newsUrlLink : String { get }
    var newsSource : String { get }
}
