//
//  NewCasesAlert.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/3/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import Foundation
import UIKit

enum CaseType: CaseIterable {
    case newCases
    case deaths
}

//delegate created to pass up case to FirstViewController
protocol NewCasesDelegate: class {
    func changeCase(newCase: CaseType)
}

class NewCasesAlert: UIView {
    
    let boxView = UIView()
    let button1 = UIButton()
    let button2 = UIButton()
    weak var delegate: NewCasesDelegate?
    
    //function to make reusable button
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

    init(casetype: CaseType) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isOpaque = false
        
        let boxView = UIView()
        boxView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        boxView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        boxView.backgroundColor = .white
        boxView.layer.cornerRadius = 8
        self.addSubview(boxView)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        //isOn is true when the casetype from FirstViewController equals case
        let button1 = makeButton(title: "New Cases", isOn: casetype == .newCases)
        button1.addTarget(self, action: #selector(button1Push), for: .touchUpInside)

        let button2 = makeButton(title: "Deaths", isOn: casetype == .deaths)
        button2.addTarget(self, action: #selector(button2Push), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [button1, button2])
        buttonStack.axis = .vertical
        buttonStack.spacing = 8
        boxView.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16).isActive = true
        buttonStack.centerYAnchor.constraint(equalTo: boxView.centerYAnchor).isActive = true
    }
    
    @objc func button1Push() {
        self.removeFromSuperview()
        delegate?.changeCase(newCase: .newCases)
    }
    
    @objc func button2Push() {
        self.removeFromSuperview()
        delegate?.changeCase(newCase: .deaths)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:] has not been implemented")
    }
}
