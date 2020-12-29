//
//  FourthViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/1/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit
import Charts

class FourthViewController: UIViewController {

    lazy var lineChartView: LineChartView = {
         let chartView = LineChartView()
         chartView.backgroundColor = .systemBlue
         return chartView
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let width = UIScreen.main.bounds.width - 16
        
        view.backgroundColor = .white
        view.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: width).isActive = true
        lineChartView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }


}
