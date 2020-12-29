//
//  NewsFeedAPI.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/14/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation

//URL for New York Times article search
var newsUrl: String = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=covid&fq=source:(\"The New York Times\")&api-key=pJsm5mxpGLIB56qiURRNGATpYOQnKylK"

//URL for current Covid data in the United States
var currentDataUrl: String = "https://api.covidtracking.com/v1/us/current.json"
