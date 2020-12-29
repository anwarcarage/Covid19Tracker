//
//  CasesChart.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/18/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import UIKit
import Charts
import Alamofire

class CasesChart: UIView, ChartViewDelegate {
    
    var incomingData: [CasesDisplayable] = []
    var incomingTotal = Int()
    var incomingDeaths = Int()
    var incomingRecovered = Int()
    var incomingPositive = Int()
    var stateData: StatesDisplayable?
//    var stateTotal = Int()
//    var stateDeaths = Int()
//    var stateRecovered = Int()
//    var statePositive = Int()
    var urlLink = String()
    
    func textStack(label1Input: String, label2Input: String) -> UIStackView {
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = label1Input
        label1.font = .systemFont(ofSize: 16)
        label2.text = label2Input
        label2.font = .systemFont(ofSize: 16)
        let labelStack = UIStackView(arrangedSubviews: [label1, label2])
        labelStack.axis = .vertical
        labelStack.spacing = 0
        
        return labelStack
    }
    
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
    
    lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.backgroundColor = .clear
        
        return chartView
    }()
    
    init(statepicked: StateType) {
        super.init(frame: .zero)
            
        self.backgroundColor = .clear
        
        switch statepicked {
        case .allRegions:
            fetchCases()
        case .alabama:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/al/current.json")
        case .alaska:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ak/current.json")
        case .arizona:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/az/current.json")
        case .arkansas:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ar/current.json")
        case .california:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ca/current.json")
        case .colorado:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/co/current.json")
        case .connecticut:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ct/current.json")
        case .delaware:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/de/current.json")
        case .florida:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/fl/current.json")
        case .georgia:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ga/current.json")
        case .hawaii:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/hi/current.json")
        case .idaho:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/id/current.json")
        case .illinois:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/il/current.json")
        case .indiana:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/in/current.json")
        case .iowa:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ia/current.json")
        case .kansas:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ks/current.json")
        case .kentucky:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ky/current.json")
        case .louisiana:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/la/current.json")
        case .maine:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/me/current.json")
        case .maryland:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/md/current.json")
        case .massachusetts:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ma/current.json")
        case .michigan:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/mi/current.json")
        case .minnesota:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/mn/current.json")
        case .mississippi:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ms/current.json")
        case .missouri:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/mo/current.json")
        case .montana:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/mt/current.json")
        case .nebraska:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ne/current.json")
        case .nevada:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nv/current.json")
        case .newHampshire:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nh/current.json")
        case .newJersey:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nj/current.json")
        case .newMexico:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nm/current.json")
        case .newYork:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ny/current.json")
        case .northCarolina:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nc/current.json")
        case .northDakota:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/nd/current.json")
        case .ohio:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/oh/current.json")
        case .oklahoma:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ok/current.json")
        case .oregon:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/or/current.json")
        case .pennsylvania:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/pa/current.json")
        case .rhodeIsland:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ri/current.json")
        case .southCarolina:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/sc/current.json")
        case .southDakota:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/sd/current.json")
        case .tennessee:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/tn/current.json")
        case .texas:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/tx/current.json")
        case .utah:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/ut/current.json")
        case .vermont:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/vt/current.json")
        case .virginia:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/va/current.json")
        case .washington:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/wa/current.json")
        case .westVirginia:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/wv/current.json")
        case .wisconsin:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/wi/current.json")
        case .wyoming:
            fetchState(urlLink: "https://api.covidtracking.com/v1/states/wy/current.json")
        }
    }
    
    //adds the subviews to the UIView
    func addViews() {
        let width = UIScreen.main.bounds.width - 16
        
        self.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pieChartView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        pieChartView.heightAnchor.constraint(equalToConstant: width).isActive = true
        pieChartView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        let positiveStack = textStack(label1Input: "Positive", label2Input: addCommas(total: incomingPositive))
        let recoveredStack = textStack(label1Input: "Recovered", label2Input: addCommas(total: incomingRecovered))
        let deathsStack = textStack(label1Input: "Deaths", label2Input: addCommas(total: incomingDeaths))

        let footerStack = UIStackView(arrangedSubviews: [positiveStack, recoveredStack, deathsStack])
        footerStack.axis = .horizontal
        footerStack.distribution = .equalSpacing
        let footerContainer = UIView()
        footerContainer.addSubview(footerStack)
        addViewConstraints(mainView: footerContainer, subView: footerStack, top: 8, left: 32, btm: -8, right: -32)

        self.addSubview(footerContainer)
        footerContainer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        footerContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        footerContainer.heightAnchor.constraint(equalToConstant: 72).isActive = true
        footerContainer.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    //sets the data and styling for the pie chart
    func setData(positive: Int, deaths: Int, recovered: Int) {
        
        var entries: [PieChartDataEntry] = []
        entries.append(PieChartDataEntry(value: Double(positive), label: "Positive"))
        entries.append(PieChartDataEntry(value: Double(deaths), label: "Deaths"))
        entries.append(PieChartDataEntry(value: Double(recovered), label: "Recovered"))

        let set1 = PieChartDataSet(entries: entries, label: "")
        set1.valueTextColor = .black
        set1.setColors(.orange, .red, .green)
        set1.sliceSpace = 1.5
        //set1.yValuePosition = PieChartDataSet.ValuePosition.outsideSlice
        
        let data = PieChartData(dataSet: set1)
        pieChartView.data = data
        pieChartView.centerText = "Total Cases: " + addCommas(total: incomingTotal)
        pieChartView.usePercentValuesEnabled = true
        pieChartView.legend.enabled = false
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.positiveSuffix = "%"
        
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }
}

extension CasesChart {
    //api call for all regions in the United States
    func fetchCases() {
        
        let request = AF.request("https://api.covidtracking.com/v1/us/daily.json")
        
        request.responseDecodable(of: [Cases].self) { (response) in
            guard let cases = response.value else { return }
            self.incomingData = cases
            self.incomingTotal = self.incomingData[0].casesTotal
            self.incomingDeaths = self.incomingData[0].casesDeaths
            self.incomingRecovered = self.incomingData[0].casesRecovered
            self.incomingPositive = self.findPositives()
            self.setData(positive: self.incomingPositive, deaths: self.incomingDeaths, recovered: self.incomingRecovered)
            self.addViews()
            self.setNeedsDisplay()
        }
    }
    
    //api call for specific states in the United States
    func fetchState(urlLink: String) {
        
        let request = AF.request(urlLink)
        
        request.responseDecodable(of: CaseStates.self) { (response) in
            guard let casesStates = response.value else { return }
            self.stateData = casesStates
            self.incomingTotal = self.stateData?.statesTotal ?? 0
            self.incomingDeaths = self.stateData?.statesDeaths ?? 0
            self.incomingRecovered = self.stateData?.statesRecovered ?? 0
            self.incomingPositive = self.findPositives()
            self.setData(positive: self.incomingPositive, deaths: self.incomingDeaths, recovered: self.incomingRecovered)
            self.addViews()
            self.setNeedsDisplay()
        }
    }
    
    //finds positive cases by subtracting deaths and recoveries from total cases
    func findPositives() -> Int {
        var positives = Int()
        positives = (self.incomingTotal - self.incomingDeaths - self.incomingRecovered)
        return positives
    }
}

//adds commas to the Int returned by the API.
func addCommas(total: Int) -> String {
    var formattedNumber = String()
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    formattedNumber = numberFormatter.string(from: NSNumber(value: total)) ?? ""
    return formattedNumber
}
