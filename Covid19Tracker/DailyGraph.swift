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
    var incomingConfirmed = Int()
    var incomingDate = Date()
    var urlLink = String()
    var timePicked: TimeType?
    
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
    
    
    init(statepicked: StateType, countrypicked: CountryType, timepicked: TimeType) {
        super.init(frame: .zero)
        
        if countrypicked == .unitedStates {
            fetchCases(urlLink: "https://corona-api.com/countries/us")
            timePicked = timepicked
        } else if countrypicked == .brazil {
            fetchCases(urlLink: "https://corona-api.com/countries/br")
            timePicked = timepicked
        } else if countrypicked == .china {
            fetchCases(urlLink: "https://corona-api.com/countries/ch")
            timePicked = timepicked
        } else if countrypicked == .france {
            fetchCases(urlLink: "https://corona-api.com/countries/fr")
            timePicked = timepicked
        } else if countrypicked == .germany {
            fetchCases(urlLink: "https://corona-api.com/countries/de")
            timePicked = timepicked
        } else if countrypicked == .italy {
            fetchCases(urlLink: "https://corona-api.com/countries/it")
            timePicked = timepicked
        } else if countrypicked == .india {
            fetchCases(urlLink: "https://corona-api.com/countries/in")
            timePicked = timepicked
        } else if countrypicked == .mexico {
            fetchCases(urlLink: "https://corona-api.com/countries/mx")
            timePicked = timepicked
        } else if countrypicked == .russia {
            fetchCases(urlLink: "https://corona-api.com/countries/ru")
            timePicked = timepicked
        } else if countrypicked == .spain {
            fetchCases(urlLink: "https://corona-api.com/countries/es")
            timePicked = timepicked
        } else if countrypicked == .unitedKingdom {
            fetchCases(urlLink: "https://corona-api.com/countries/gb")
            timePicked = timepicked
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
    
    func setData() {
        var graphValues: [ChartDataEntry] = []
        
        switch timePicked {
        case .allTime:
            for data in dailyData.reversed() {
                var xValue = Date()
                var yValue = Int()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                xValue = dateFormatter.date(from: data.dailyDate) ?? Date()
                if data.dailyConfirmed > 1000000 {
                    yValue = data.dailyConfirmed/10
                } else {
                    yValue = data.dailyConfirmed
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
                if data.dailyConfirmed > 1000000 {
                    yValue = data.dailyConfirmed/10
                } else {
                    yValue = data.dailyConfirmed
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
                if data.dailyConfirmed > 1000000 {
                    yValue = data.dailyConfirmed/10
                } else {
                    yValue = data.dailyConfirmed
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
                if data.dailyConfirmed > 1000000 {
                    yValue = data.dailyConfirmed/10
                } else {
                    yValue = data.dailyConfirmed
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
            self.setData()
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


