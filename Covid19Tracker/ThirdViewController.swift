//
//  ThirdViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/1/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit
import Alamofire


class ThirdViewController: UIViewController {
            
    var incomingData: [Displayable] = []
    
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
           
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

        override func viewDidLoad() {
            super.viewDidLoad()

            view.backgroundColor = .lightGray
                        
            let width = UIScreen.main.bounds.width - 16
            let height = CGFloat(width * 1.5)

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: width, height: height)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumInteritemSpacing = 8
                flowLayout.minimumLineSpacing = 8

            collectionView.setCollectionViewLayout(flowLayout, animated: false)
            
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.delegate = self

            //don't forget this!!!
            collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")

            view.addSubview(collectionView)

            addViewConstraints(mainView: view, subView: collectionView, top: 0, left: 0, btm: 0, right: 0)

            navigationItem.title = "News Flash"

            fetchNews()
        }
}

extension ThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  incomingData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCell

        let news = incomingData[indexPath.row]
            cell?.update(
                newsTitle: news.newsTitle,
                newsBody: news.newsBody,
                newsUrlLink: news.newsUrlLink,
                newsSource: news.newsSource,
                newsImg: news.newsMedia[0].imgUrl
        )
        
        return cell ?? UICollectionViewCell()
    }
}

extension ThirdViewController {
    func fetchNews() {
        //1
        let request = AF.request("https://api.nytimes.com/svc/search/v2/articlesearch.json?q=covid&api-key=pJsm5mxpGLIB56qiURRNGATpYOQnKylK")
        //2
        request.responseDecodable(of: News.self) { (response) in
            guard let news = response.value else { return }
            self.incomingData = news.response.docs
            self.collectionView.reloadData()
        }
    }
}

class NewsCell: UICollectionViewCell {
    
    let width = UIScreen.main.bounds.width - 16
    
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.cellImage.image = image
            }
        }
    }
    
    let cellTitle = UILabel()
    let cellBody = UILabel()
    var cellLink = String()
    let cellSource = UILabel()
    let cellImage = UIImageView()
    let clickableText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellTitle.font = UIFont(name: "PingFang", size: 12)
        cellTitle.lineBreakMode = .byWordWrapping
        cellTitle.numberOfLines = 0
        cellBody.font = UIFont(name: "Baskerville", size: 12)
        cellBody.lineBreakMode = .byWordWrapping
        cellBody.numberOfLines = 0
        cellSource.font = UIFont(name: "Arial", size: 8)
        clickableText.font = UIFont(name: "Arial", size: 8)
        clickableText.textColor = .blue
        cellImage.layer.masksToBounds = true
        cellImage.layer.cornerRadius = 12
        cellImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        clickableText.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        clickableText.addGestureRecognizer(gestureRecognizer)
        
        let footerStack = UIStackView(arrangedSubviews: [clickableText, UIView(), cellSource])
        footerStack.axis = .horizontal
        
        let cellContainer = UIView()
        cellContainer.heightAnchor.constraint(equalToConstant: width).isActive = true
        cellContainer.addSubview(cellImage)
        addViewConstraints(mainView: cellContainer, subView: cellImage, top: 0, left: 0, btm: 0, right: 0)
        
        let textStack = UIStackView(arrangedSubviews: [cellTitle, cellBody, UIView(), footerStack])
        textStack.axis = .vertical
        textStack.spacing = 8
        let textBodyContainer = UIView()
        textBodyContainer.addSubview(textStack)
        addViewConstraints(mainView: textBodyContainer, subView: textStack, top: 0, left: 8, btm: 0, right: -8)
        
        let mainStack = UIStackView(arrangedSubviews: [cellContainer, textBodyContainer])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        let mainContainer = UIView()
        mainContainer.addSubview(mainStack)
        addViewConstraints(mainView: mainContainer, subView: mainStack, top: 0, left: 0, btm: -8, right: 0)
    
        contentView.addSubview(mainContainer)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 1
        
        addViewConstraints(mainView: contentView, subView: mainContainer, top: 0, left: 0, btm: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(newsTitle: String, newsBody: String, newsUrlLink: String, newsSource: String, newsImg: String) {
        cellTitle.text = newsTitle
        cellBody.text = newsBody
        cellLink = newsUrlLink
        cellSource.text = "source: " + newsSource
        setImage(from: "https://www.nytimes.com/" + newsImg)
        clickableText.text = "Read Article"
   }
    
    @objc func labelClicked() {
        if let url = URL(string: cellLink) {
            UIApplication.shared.open(url)
        }
    }
}

