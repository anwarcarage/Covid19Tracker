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

//delegate created to pass up case to FirstViewController
protocol CountryDelegate: class {
    func changeCountry(newCountry: CountryType)
}

class CountryAlert: UIView {
    
    let boxView = UIView()
    let firstViewController = FirstViewController()
    var allButtons = [UIButton]()
    weak var delegate: CountryDelegate?
    
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
        boxView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        boxView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        boxView.backgroundColor = .white
        boxView.layer.cornerRadius = 8
        self.addSubview(boxView)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       
        //loops thru countries array. isOn is true when the enum implicit raw value equals the index value of the array
        //the created button is added to the allButtons array
        for (index, country) in firstViewController.btn2Array.enumerated() {
            let button = makeButton(title: country, isOn: countrytype.rawValue == index)
            button.tag = index
            button.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)

            allButtons.append(button)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: allButtons)
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        boxView.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16).isActive = true
        buttonStack.centerYAnchor.constraint(equalTo: boxView.centerYAnchor).isActive = true
    }
    
    @objc func buttonPush(_ sender: UIButton) {
        self.removeFromSuperview()
        //loop by array count. if the button tag matches the array index then assign the case accordingly
        for i in 0...firstViewController.btn2Array.count {
            if sender.tag == i {
                delegate?.changeCountry(newCountry: CountryType(rawValue: i)!)
            }
        }
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }    
}
