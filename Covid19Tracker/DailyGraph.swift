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

class DailyGraph: UIView, ChartViewDelegate {
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        
        return chartView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = UIScreen.main.bounds.width - 16
        
        self.backgroundColor = .clear
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineChartView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: width).isActive = true
        lineChartView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: xValues, label: "X Values")
        set1.drawCirclesEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    let xValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 17.0),
        ChartDataEntry(x: 11.0, y: 15.0),
        ChartDataEntry(x: 12.0, y: 10.0),
        ChartDataEntry(x: 13.0, y: 10.0),
        ChartDataEntry(x: 14.0, y: 15.0),
        ChartDataEntry(x: 15.0, y: 6.0),
        ChartDataEntry(x: 16.0, y: 6.0),
        ChartDataEntry(x: 17.0, y: 7.0),
        ChartDataEntry(x: 18.0, y: 3.0),
        ChartDataEntry(x: 19.0, y: 10.0),
        ChartDataEntry(x: 20.0, y: 12.0),
        ChartDataEntry(x: 21.0, y: 15.0),
        ChartDataEntry(x: 22.0, y: 17.0),
        ChartDataEntry(x: 23.0, y: 15.0),
        ChartDataEntry(x: 24.0, y: 10.0),
        ChartDataEntry(x: 25.0, y: 10.0),
        ChartDataEntry(x: 26.0, y: 10.0),
        ChartDataEntry(x: 27.0, y: 17.0),
        ChartDataEntry(x: 28.0, y: 13.0),
        ChartDataEntry(x: 29.0, y: 20.0),
        ChartDataEntry(x: 30.0, y: 24.0),

        
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }
}
