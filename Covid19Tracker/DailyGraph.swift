//
//  CaseGraph.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/17/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import UIKit
import Charts
import Alamofire

class DailyGraph: UIView, ChartViewDelegate {
    
    var dailyData: [DailyDisplayable] = []
    var dailyStateData: [CasesDisplayable] = []
    var urlLink = String()
    var timePicked: TimeType?
    var casePicked: CaseType?
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        
        return chartView
    }()
    
    
    init(statepicked: StateType, countrypicked: CountryType, timepicked: TimeType, casepicked: CaseType) {
        super.init(frame: .zero)
        
        if countrypicked == .unitedStates {
            timePicked = timepicked
            casePicked = casepicked
            switch statepicked {
            case .allRegions:
                fetchCases(urlLink: "https://corona-api.com/countries/us")
            case .alabama:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/al/daily.json")
            case .alaska:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ak/daily.json")
            case .arizona:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/az/daily.json")
            case .arkansas:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ar/daily.json")
            case .california:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ca/daily.json")
            case .colorado:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/co/daily.json")
            case .connecticut:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ct/daily.json")
            case .delaware:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/de/daily.json")
            case .florida:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/fl/daily.json")
            case .georgia:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ga/daily.json")
            case .hawaii:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/hi/daily.json")
            case .idaho:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/id/daily.json")
            case .illinois:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/il/daily.json")
            case .indiana:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/in/daily.json")
            case .iowa:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ia/daily.json")
            case .kansas:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ks/daily.json")
            case .kentucky:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ky/daily.json")
            case .louisiana:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/la/daily.json")
            case .maine:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/me/daily.json")
            case .maryland:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/md/daily.json")
            case .massachusetts:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ma/daily.json")
            case .michigan:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/mi/daily.json")
            case .minnesota:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/mn/daily.json")
            case .mississippi:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ms/daily.json")
            case .missouri:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/mo/daily.json")
            case .montana:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/mt/daily.json")
            case .nebraska:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ne/daily.json")
            case .nevada:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nv/daily.json")
            case .newHampshire:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nh/daily.json")
            case .newJersey:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nj/daily.json")
            case .newMexico:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nm/daily.json")
            case .newYork:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ny/daily.json")
            case .northCarolina:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nc/daily.json")
            case .northDakota:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/nd/daily.json")
            case .ohio:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/oh/daily.json")
            case .oklahoma:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ok/daily.json")
            case .oregon:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/or/daily.json")
            case .pennsylvania:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/pa/daily.json")
            case .rhodeIsland:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ri/daily.json")
            case .southCarolina:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/sc/daily.json")
            case .southDakota:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/sd/daily.json")
            case .tennessee:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/tn/daily.json")
            case .texas:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/tx/daily.json")
            case .utah:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/ut/daily.json")
            case .vermont:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/vt/daily.json")
            case .virginia:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/va/daily.json")
            case .washington:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/wa/daily.json")
            case .westVirginia:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/wv/daily.json")
            case .wisconsin:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/wi/daily.json")
            case .wyoming:
                fetchState(urlLink: "https://api.covidtracking.com/v1/states/wy/daily.json")
            }
        } else if countrypicked == .brazil {
            fetchCases(urlLink: "https://corona-api.com/countries/br")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .china {
            fetchCases(urlLink: "https://corona-api.com/countries/ch")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .france {
            fetchCases(urlLink: "https://corona-api.com/countries/fr")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .germany {
            fetchCases(urlLink: "https://corona-api.com/countries/de")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .italy {
            fetchCases(urlLink: "https://corona-api.com/countries/it")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .india {
            fetchCases(urlLink: "https://corona-api.com/countries/in")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .mexico {
            fetchCases(urlLink: "https://corona-api.com/countries/mx")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .russia {
            fetchCases(urlLink: "https://corona-api.com/countries/ru")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .spain {
            fetchCases(urlLink: "https://corona-api.com/countries/es")
            timePicked = timepicked
            casePicked = casepicked
        } else if countrypicked == .unitedKingdom {
            fetchCases(urlLink: "https://corona-api.com/countries/gb")
            timePicked = timepicked
            casePicked = casepicked
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func addView() {
        let width = UIScreen.main.bounds.width - 16
        
        self.backgroundColor = .clear
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineChartView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: width).isActive = true
        lineChartView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setCountryData() {
        var graphValues: [ChartDataEntry] = []
        
        switch timePicked {
        case .allTime:
            for data in dailyData.reversed() {
                var xValue = Date()
                var yValue = Int()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                xValue = dateFormatter.date(from: data.dailyDate) ?? Date()
                
                if casePicked == .newCases {
                    //used to handle bad api numbers (looks like a number typo)
                    if data.dailyConfirmed > 1000000 {
                        yValue = data.dailyConfirmed/10
                    } else {
                        yValue = data.dailyConfirmed
                    }
                } else if casePicked == .deaths {
                    yValue = data.dailyDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .ThirtyDays:
            for (index, data) in dailyData.enumerated().reversed() where index < 30 {
                var xValue = Date()
                var yValue = Int()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                xValue = dateFormatter.date(from: data.dailyDate) ?? Date()

                if casePicked == .newCases {
                    //used to handle bad api numbers (looks like a number typo)
                    if data.dailyConfirmed > 1000000 {
                        yValue = data.dailyConfirmed/10
                    } else {
                        yValue = data.dailyConfirmed
                    }
                } else if casePicked == .deaths {
                    yValue = data.dailyDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .twoWeeks:
            for (index, data) in dailyData.enumerated().reversed() where index < 14 {
                var xValue = Date()
                var yValue = Int()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                xValue = dateFormatter.date(from: data.dailyDate) ?? Date()

                if casePicked == .newCases {
                    //used to handle bad api numbers (looks like a number typo)
                    if data.dailyConfirmed > 1000000 {
                        yValue = data.dailyConfirmed/10
                    } else {
                        yValue = data.dailyConfirmed
                    }
                } else if casePicked == .deaths {
                    yValue = data.dailyDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .oneWeek:
            for (index, data) in dailyData.enumerated().reversed() where index < 7 {
                var xValue = Date()
                var yValue = Int()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                xValue = dateFormatter.date(from: data.dailyDate) ?? Date()

                if casePicked == .newCases {
                    //used to handle bad api numbers (looks like a number typo)
                    if data.dailyConfirmed > 1000000 {
                        yValue = data.dailyConfirmed/10
                    } else {
                        yValue = data.dailyConfirmed
                    }
                } else if casePicked == .deaths {
                    yValue = data.dailyDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .none:
            print("error: TimeType case test failure")
        }
    
        let set1 = LineChartDataSet(entries: graphValues, label: "New cases by day")
        set1.drawCirclesEnabled = false
        
        let customXFormatter = MyXAxisFormatter()
        lineChartView.xAxis.valueFormatter = customXFormatter
        lineChartView.xAxis.labelRotationAngle = -45
        
        let customYFormatter = MyYAxisFormatter()
        lineChartView.leftAxis.valueFormatter = customYFormatter
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    func setStateData() {
        var graphValues: [ChartDataEntry] = []
        
        switch timePicked {
        case .allTime:
            for data in dailyStateData.reversed() {
                var xValue = Date()
                var yValue = Int()
                let dateString = String(data.casesDate)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                xValue = dateFormatter.date(from: dateString) ?? Date()
                
                if casePicked == .newCases {
                    yValue = data.casesPositive
                } else if casePicked == .deaths {
                    yValue = data.casesDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .ThirtyDays:
            for (index, data) in dailyStateData.enumerated().reversed() where index < 30 {
                var xValue = Date()
                var yValue = Int()
                let dateString = String(data.casesDate)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                xValue = dateFormatter.date(from: dateString) ?? Date()
                
                if casePicked == .newCases {
                    yValue = data.casesPositive
                } else if casePicked == .deaths {
                    yValue = data.casesDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .twoWeeks:
                        for (index, data) in dailyStateData.enumerated().reversed() where index < 14 {
                var xValue = Date()
                var yValue = Int()
                let dateString = String(data.casesDate)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                xValue = dateFormatter.date(from: dateString) ?? Date()
                
                if casePicked == .newCases {
                    yValue = data.casesPositive
                } else if casePicked == .deaths {
                    yValue = data.casesDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .oneWeek:
            for (index, data) in dailyStateData.enumerated().reversed() where index < 7 {
                var xValue = Date()
                var yValue = Int()
                let dateString = String(data.casesDate)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                xValue = dateFormatter.date(from: dateString) ?? Date()
                
                if casePicked == .newCases {
                    yValue = data.casesPositive
                } else if casePicked == .deaths {
                    yValue = data.casesDeaths
                }
                
                let dataEntry = ChartDataEntry(x: xValue.timeIntervalSince1970, y: Double(yValue))
                graphValues.append(dataEntry)
            }
        case .none:
            print("error: TimeType case test failure")
        }
        
        let set1 = LineChartDataSet(entries: graphValues, label: "New cases by day")
        set1.drawCirclesEnabled = false
        
        let customXFormatter = MyXAxisFormatter()
        lineChartView.xAxis.valueFormatter = customXFormatter
        lineChartView.xAxis.labelRotationAngle = -45
        
        let customYFormatter = MyYAxisFormatter()
        lineChartView.leftAxis.valueFormatter = customYFormatter
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }
}

extension DailyGraph {
    //api call for all regions in the United States
    func fetchCases(urlLink: String) {
        
        let request = AF.request(urlLink)
        
        request.responseDecodable(of:CaseCountries.self) { (response) in
            guard let dailyCases = response.value else { return }
            self.dailyData = dailyCases.data.timeline
            self.setCountryData()
            self.addView()
            self.setNeedsDisplay()
        }
    }
    
    func fetchState(urlLink: String) {
        
        let request = AF.request(urlLink)
        
        request.responseDecodable(of:[Cases].self) { (response) in
            guard let dailyCases = response.value else { return }
            self.dailyStateData = dailyCases
            self.setStateData()
            self.addView()
            self.setNeedsDisplay()
        }
    }
}

class MyXAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let intDate = Date(timeIntervalSince1970: value)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        return dateFormatter.string(from: intDate)
    }
}

class MyYAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var formattedNumber = String()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        formattedNumber = numberFormatter.string(from: NSNumber(value: value)) ?? ""
        
        return formattedNumber
    }
}


