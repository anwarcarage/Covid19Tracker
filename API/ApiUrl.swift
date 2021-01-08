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

//URL for current Covid data on countries around the world
//:code will be substituted with the countries ISO 3166-1 alpha-2 format of country code
var currentCountryUrl: String = "https://corona-api.com/countries/:code"

//URL for the 2019 estimated populations for each state
var currentPopulationUrl: String = "http://api.census.gov/data/2019/pep/population?get=POP,NAME,STATE&for=state:*&key=4eff9ac72c73ddce473345aafe94dbc473d983d7"
