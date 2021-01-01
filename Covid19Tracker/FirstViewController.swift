//
//  FirstViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 11/30/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit
import Charts

class FirstViewController: UIViewController, NewCasesDelegate, CountryDelegate, StatesDelegate, TimeDelegate {
    
    let titleLbl = UILabel()
    var selectedCase: CaseType = .newCases
    var selectedCountry: CountryType = .unitedStates
    var selectedState: StateType = .allRegions
    var selectedTime: TimeType = .allTime
    var btn2Array:[String] = ["Brazil", "China", "France", "Germany", "Italy", "India", "Mexico", "Russia", "Spain", "United Kindom", "United States"]
    var btn3Array:[String] = ["All regions", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var btn4Array:[String] = ["All Time", "1 week", "2 weeks", "30 days"]
    
    //handles case delegate
    func changeCase(newCase: CaseType) {
        selectedCase = newCase
        
        self.viewDidLoad()
    }
    
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
    
    func changeTime(newTime: TimeType) {
      selectedTime = newTime
        
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
    
    //function to add contraints and reduce overall code
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let width = UIScreen.main.bounds.width - 16
         
        var graph = DailyGraph(statepicked: selectedState, countrypicked: selectedCountry, timepicked: selectedTime)
        
        titleLbl.text = "Daily Statistics"
        titleLbl.font = .systemFont(ofSize: 32)
                
        let divider = UIView()
        let dividerContainer = UIView()
        dividerContainer.addSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = .lightGray
        addViewConstraints(mainView: dividerContainer, subView: divider, top: 0, left: 0, btm: 0, right: 0)

        let firstBtn = makeButton(title: updateBtn1Title())
        firstBtn.addTarget(self, action: #selector(firstAlert), for: .touchUpInside)
        let secondBtn = makeButton(title: updateBtn2Title())
        secondBtn.addTarget(self, action: #selector(secondAlert), for: .touchUpInside)
        let thirdBtn = makeButton(title: updateBtn3Title())
        thirdBtn.addTarget(self, action: #selector(thirdAlert), for: .touchUpInside)
        let fourthBtn = makeButton(title: updateBtn4Title())
        fourthBtn.addTarget(self, action: #selector(fourthAlert), for: .touchUpInside)

        //hides region button if any country aside from the United States is selected for button 3
        func hideButton() -> UIScrollView {
            if selectedCountry == .unitedStates {
                let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn, thirdBtn, fourthBtn])
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
                let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn, fourthBtn])
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
        
        let bodyContainer = UIView()
        bodyContainer.addSubview(graph)
        bodyContainer.heightAnchor.constraint(equalToConstant: width).isActive = true
        bodyContainer.widthAnchor.constraint(equalToConstant: width).isActive = true
        addViewConstraints(mainView: bodyContainer, subView: graph, top: 0, left: 0, btm: 0, right: 0)
        
        let mainStack = UIStackView(arrangedSubviews: [headerContainer, bodyContainer])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        let mainContainer = UIView()
        mainContainer.addSubview(mainStack)
        mainContainer.backgroundColor = .white
        mainContainer.heightAnchor.constraint(equalToConstant: 600).isActive = true
        mainContainer.layer.cornerRadius = 12
        mainContainer.layer.borderColor = UIColor.black.cgColor
        mainContainer.layer.borderWidth = 1
        mainContainer.layer.shadowColor = UIColor.black.cgColor
        mainContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        mainContainer.layer.shadowRadius = 2
        mainContainer.layer.shadowOpacity = 1
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: mainContainer.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8).isActive = true
        
        view.addSubview(mainContainer)
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    //updates button title
    func updateBtn1Title() -> String {
        var newTitle = String()
        
        newTitle = selectedCase == .newCases ? "New Cases" : "Deaths"
        
        return newTitle
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
    
    //updates button title
    func updateBtn4Title() -> String {
        var time = String()
        
        for i in 0...btn4Array.count {
            if  i == selectedTime.rawValue {
                time = btn4Array[i]
            }
        }
        return time
    }
    
    //first button loads the NewCasesAlert UIVIew & identifies delegate
    @objc func firstAlert() {
        let firstAlert = NewCasesAlert(casetype: selectedCase)
        firstAlert.delegate = self
        view.addSubview(firstAlert)
        addViewConstraints(mainView: view, subView: firstAlert, top: 0, left: 0, btm: 0, right: 0)
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
    
    //fourth button loads the TimeAlert UIView & identifies delegate
    @objc func fourthAlert() {
        let fourthAlert = TimeAlert(timetype: selectedTime)
        fourthAlert.delegate = self
        view.addSubview(fourthAlert)
        addViewConstraints(mainView: view, subView: fourthAlert, top: 0, left: 0, btm: 0, right: 0 )
    }
}

