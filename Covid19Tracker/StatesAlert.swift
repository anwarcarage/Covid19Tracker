//
//  StatesAlert.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/11/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import UIKit

enum StateType: Int, CaseIterable {
    case allRegions, alabama, alaska, arizona, arkansas, california, colorado, connecticut, delaware, florida, georgia, hawaii, idaho, illinois, indiana, iowa, kansas, kentucky, louisiana, maine, maryland, massachusetts, michigan, minnesota, mississippi, missouri, montana, nebraska, nevada, newHampshire, newJersey, newMexico, newYork, northCarolina, northDakota, ohio, oklahoma, oregon, pennsylvania, rhodeIsland, southCarolina, southDakota, tennessee, texas, utah, vermont, virginia, washington, westVirginia, wisconsin, wyoming
}

//delegate created to pass up case to FirstViewController
protocol StatesDelegate: class {
    func changeState(newState: StateType)
}

class StatesAlert: UIView {
    
  let boxView = UIView()
    let firstViewController = FirstViewController()
    var allButtons = [UIButton]()
    weak var delegate: StatesDelegate?
    
    func makeButton(title: String, isOn: Bool) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        if isOn == true {
            button.setImage(UIImage(named: "checkmark"), for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
        }
        else {
            button.setImage(UIImage(named: ""), for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
        }

        return button
    }
    
    //function to add contraints and reduce overall code
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
    
    init(statetype: StateType) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isOpaque = false
        
        let boxView = UIView()
        boxView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        boxView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        boxView.backgroundColor = .white
        boxView.layer.cornerRadius = 8
        self.addSubview(boxView)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
       
        //loops thru countries array. isOn is true when the enum implicit raw value equals the index value of the array
        //the created button is added to the allButtons array
        for (index, state) in firstViewController.btn3Array.enumerated() {
            let button = makeButton(title: state, isOn: statetype.rawValue == index)
            button.tag = index
            button.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)

            allButtons.append(button)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: allButtons)
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        let buttonContainer = UIScrollView()
        buttonContainer.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.topAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.topAnchor).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.leadingAnchor).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.bottomAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.trailingAnchor).isActive = true
        boxView.addSubview(buttonContainer)
        buttonStack.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: 0).isActive = true
        addViewConstraints(mainView: boxView, subView: buttonContainer, top: 8, left: 0, btm: -8, right: 0)
        
    }
    
    @objc func buttonPush(_ sender: UIButton) {
        self.removeFromSuperview()
        //loop by array count. if the button tag matches the array index then assign the case accordingly
        for i in 0...firstViewController.btn3Array.count {
            if sender.tag == i {
                delegate?.changeState(newState: StateType(rawValue: i)!)
            }
        }
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }
    
}
