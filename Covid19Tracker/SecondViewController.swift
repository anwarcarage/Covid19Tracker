//
//  SecondViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 11/30/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CountryDelegate, StatesDelegate {
    
    let titleLbl = UILabel()
    var selectedCountry: CountryType = .unitedStates
    var selectedState: StateType = .allRegions
    var btn2Array:[String] = ["Brazil", "China", "France", "Germany", "Italy", "India", "Mexico", "Russia", "Spain", "United Kindom", "United States"]
    var btn3Array:[String] = ["All regions", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var btn4Array:[String] = ["All Time", "1 week", "2 weeks", "30 days"]
    
    //handles country delegate
    func changeCountry(newCountry: CountryType) {
        selectedCountry = newCountry
        
        self.viewDidLoad()
    }
    
    //handles state delegate
    func changeState(newState: StateType) {
        selectedState = newState
        
        self.viewDidLoad()
    }
    
    //function to make reusable button
    func makeButton(title: String) -> UIButton {
        let button = UIButton()

        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.5
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(named: "caret-down"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12)
        button.sizeToFit()
        
        return button
    }
    
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pieChart = CasesChart(statepicked: selectedState)
        view.backgroundColor = .white
        
        titleLbl.text = "Cases"
        titleLbl.font = .systemFont(ofSize: 32)
        
        let divider = UIView()
        let dividerContainer = UIView()
        dividerContainer.addSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = .lightGray
        addViewConstraints(mainView: dividerContainer, subView: divider, top: 0, left: 0, btm: 0, right: 0)

        let firstBtn = makeButton(title: "Total")
        let secondBtn = makeButton(title: updateBtn2Title())
        secondBtn.addTarget(self, action: #selector(secondAlert), for: .touchUpInside)
        let thirdBtn = makeButton(title: updateBtn3Title())
        thirdBtn.addTarget(self, action: #selector(thirdAlert), for: .touchUpInside)
        
        //hides region button if any country aside from the United States is selected for button 3
        func hideButton() -> UIScrollView {
            if selectedCountry == .unitedStates {
                let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn, thirdBtn])
                buttonStack.axis = .horizontal
                buttonStack.spacing = 8
                let buttonContainer = UIScrollView()
                buttonContainer.addSubview(buttonStack)
                buttonStack.translatesAutoresizingMaskIntoConstraints = false
                buttonStack.topAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.topAnchor).isActive = true
                buttonStack.leadingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.leadingAnchor).isActive = true
                buttonStack.bottomAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.bottomAnchor).isActive = true
                buttonStack.trailingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.trailingAnchor).isActive = true
                return buttonContainer
             } else {
                let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn])
                buttonStack.axis = .horizontal
                buttonStack.spacing = 8
                let buttonContainer = UIScrollView()
                buttonContainer.addSubview(buttonStack)
                buttonStack.translatesAutoresizingMaskIntoConstraints = false
                buttonStack.topAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.topAnchor).isActive = true
                buttonStack.leadingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.leadingAnchor).isActive = true
                buttonStack.bottomAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.bottomAnchor).isActive = true
                buttonStack.trailingAnchor.constraint(equalTo: buttonContainer.contentLayoutGuide.trailingAnchor).isActive = true
                return buttonContainer
             }
        }
        
        let headerStack = UIStackView(arrangedSubviews: [titleLbl, dividerContainer, hideButton()])
        headerStack.axis = .vertical
        headerStack.spacing = 8
        let headerContainer = UIView()
        headerContainer.addSubview(headerStack)
        headerContainer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        addViewConstraints(mainView: headerContainer, subView: headerStack, top: 0, left: 0, btm: 0, right: 0)
        
        let cardStack = UIStackView(arrangedSubviews: [headerContainer, pieChart])
        cardStack.axis = .vertical
        cardStack.spacing = 8
        let mainContainer = UIView()
        mainContainer.addSubview(cardStack)
        mainContainer.backgroundColor = .white
        mainContainer.heightAnchor.constraint(equalToConstant: 600).isActive = true
        mainContainer.layer.cornerRadius = 12
        mainContainer.layer.borderColor = UIColor.black.cgColor
        mainContainer.layer.borderWidth = 1
        mainContainer.layer.shadowColor = UIColor.black.cgColor
        mainContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        mainContainer.layer.shadowRadius = 2
        mainContainer.layer.shadowOpacity = 1
        addViewConstraints(mainView: mainContainer, subView: cardStack, top: 8, left: 8, btm: 8, right: -8)
        
        let mainStack = UIStackView(arrangedSubviews: [mainContainer, UIView()])
        mainStack.axis = .vertical
        mainStack.addSubview(mainContainer)
        
        view.addSubview(mainStack)
        addViewConstraints(mainView: view, subView: mainStack, top: 8, left: 8, btm: 0, right: -8)
    }
    
    //updates button title
    func updateBtn2Title() -> String {
        var country = String()
        
        for i in 0...btn2Array.count {
            if  i == selectedCountry.rawValue {
                country = btn2Array[i]
            }
        }
        return country
    }
    
    //updates button title
    func updateBtn3Title() -> String {
        var state = String()
        
        for i in 0...btn3Array.count {
            if  i == selectedState.rawValue {
                state = btn3Array[i]
            }
        }
        return state
    }
    
    //second button loads the CountryAlert UIView & identifies delegate
    @objc func secondAlert() {
        let secondAlert = CountryAlert(countrytype: selectedCountry)
        secondAlert.delegate = self
        view.addSubview(secondAlert)
        addViewConstraints(mainView: view, subView: secondAlert, top: 0, left: 0, btm: 0, right: 0 )
    }
    
    //third button loads the StateAlert UIView & identifies delegate
    @objc func thirdAlert() {
        let thirdAlert = StatesAlert(statetype: selectedState)
        thirdAlert.delegate = self
        view.addSubview(thirdAlert)
        addViewConstraints(mainView: view, subView: thirdAlert, top: 0, left: 0, btm: 0, right: 0 )
    }
}

