//
//  CountryAlert.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/4/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import UIKit

enum CountryType: Int, CaseIterable {
    case brazil, china, france, germany, italy, india, mexico, russia, spain, unitedKingdom, unitedStates
}

class CountryAlert: UIView {
    
    let boxView = UIView()
    let countries:[String] = ["Brazil", "China", "France", "Germany", "Italy", "India", "Mexico", "Russia", "Spain", "United Kindom", "United States"]
    
    func makeButton(title: String, isOn: Bool) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        if isOn == true {
            button.setImage(UIImage(named: "checkmark"), for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
        }
        else {
            button.setImage(UIImage(named: ""), for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
        }

        return button
    }
    
    init(countrytype: CountryType) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isOpaque = false
        
        let boxView = UIView()
        //boxView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        boxView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        boxView.backgroundColor = .white
        boxView.layer.cornerRadius = 8
        self.addSubview(boxView)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        for (index, country) in countries.enumerated() {
            //var tag: Int = countrytype(raw)
            //makeButton(title: country, isOn: countrytype(rawValue) == index)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }    
    
    
    
}
