//
//  FirstViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 11/30/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, Button1Delegate {
    
    let titleLbl = UILabel()
    var selectedCase: CaseType = .newCases
    var selectedCountry: CountryType = .unitedStates
    
    func changeCase(newCase: CaseType) {
        selectedCase = newCase
        
        self.viewDidLoad()
    }
    
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
        
        view.backgroundColor = .white
                
        titleLbl.text = "Daily Statistics"
        titleLbl.font = .systemFont(ofSize: 32)
                
        let divider = UIView()
        let dividerContainer = UIView()
        dividerContainer.addSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = .lightGray
        addViewConstraints(mainView: dividerContainer, subView: divider, top: 0, left: 0, btm: 0, right: 0)

        let firstBtn = makeButton(title: updateBtnTitle())
        firstBtn.addTarget(self, action: #selector(firstAlert), for: .touchUpInside)
        let secondBtn = makeButton(title: "United States")
        let thirdBtn = makeButton(title: "All regions")
        let fourthBtn = makeButton(title: "All time")

        let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn, thirdBtn, fourthBtn])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        let buttonContainer = UIScrollView()
        buttonContainer.addSubview(buttonStack)
        addViewConstraints(mainView: buttonContainer, subView: buttonStack, top: 8, left: 8, btm: -8, right: -8)
        
        let cardStack = UIStackView(arrangedSubviews: [titleLbl, dividerContainer, buttonContainer, UIView()])
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
        addViewConstraints(mainView: mainContainer, subView: cardStack, top: 8, left: 8, btm: -8, right: -8)
        
        let mainStack = UIStackView(arrangedSubviews: [mainContainer, UIView()])
        mainStack.axis = .vertical
        mainStack.addSubview(mainContainer)
        
        view.addSubview(mainStack)
        addViewConstraints(mainView: view, subView: mainStack, top: 8, left: 8, btm: -8, right: -8)
    }
    
    func updateBtnTitle() -> String {
        var newTitle = String()
        
        if selectedCase == .newCases {
            newTitle = "New Cases"
        } else if selectedCase == .deaths {
            newTitle = "Deaths"
        }
        
        return newTitle
    }
    
    @objc func firstAlert() {
        let firstAlert = NewCasesAlert(casetype: selectedCase)
        firstAlert.delegate = self
        view.addSubview(firstAlert)
        addViewConstraints(mainView: view, subView: firstAlert, top: 0, left: 0, btm: 0, right: 0)
    }
    
    @objc func secondAlert() {
        let secondAlert = CountryAlert(countrytype: selectedCountry)
        view.addSubview(secondAlert)
        addViewConstraints(mainView: view, subView: secondAlert, top: 0, left: 0, btm: 0, right: 0 )
    }
}

