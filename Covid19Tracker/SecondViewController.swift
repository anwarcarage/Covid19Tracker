//
//  SecondViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 11/30/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let titleLbl = UILabel()
    
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
    
    func textStack(label1Input: String, label2Input: String) -> UIStackView {
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = label1Input
        label1.font = .systemFont(ofSize: 16)
        label2.text = label2Input
        label2.font = .systemFont(ofSize: 16)
        let labelStack = UIStackView(arrangedSubviews: [label1, label2])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        
        return labelStack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let secondBtn = makeButton(title: "United States")
        let thirdBtn = makeButton(title: "All regions")

        let buttonStack = UIStackView(arrangedSubviews: [firstBtn, secondBtn, thirdBtn])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        let buttonContainer = UIScrollView()
        buttonContainer.addSubview(buttonStack)
        addViewConstraints(mainView: buttonContainer, subView: buttonStack, top: 8, left: 8, btm: -8, right: -8)
        
        let casesStack = textStack(label1Input: "Cases", label2Input: "100k")
        let populationStack = textStack(label1Input: "Population", label2Input: "100 Million")
        let deathsStack = textStack(label1Input: "Deaths", label2Input: "100")
        
        let infoStack = UIStackView(arrangedSubviews: [casesStack, populationStack, deathsStack])
        infoStack.axis = .horizontal
        infoStack.distribution = .equalSpacing
        
        let infoContainer = UIView()
        infoContainer.addSubview(infoStack)
        addViewConstraints(mainView: infoContainer, subView: infoStack, top: 8, left: 32, btm: -8, right: -32)
        
        let cardStack = UIStackView(arrangedSubviews: [titleLbl, dividerContainer, buttonContainer, infoContainer])
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
}

