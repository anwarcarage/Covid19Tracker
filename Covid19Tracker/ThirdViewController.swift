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
            let height = CGFloat(180)

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: width, height: height)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumInteritemSpacing = 8
                flowLayout.minimumLineSpacing = 8

            collectionView.setCollectionViewLayout(flowLayout, animated: false)
            
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.delegate = self

            // everyone forgets this
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
                newsSource: news.newsSource
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
    
    func addViewConstraints(mainView: UIView, subView: UIView, top: CGFloat, left: CGFloat, btm: CGFloat, right: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        subView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: left).isActive = true
        subView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: btm).isActive = true
        subView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: right).isActive = true
    }
    
    let cellTitle = UILabel()
    let cellBody = UILabel()
    var cellLink = String()
    let cellSource = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellTitle.font = UIFont(name: "PingFang", size: 12)
        cellTitle.lineBreakMode = .byWordWrapping
        cellTitle.numberOfLines = 0
        cellBody.font = UIFont(name: "Baskerville", size: 12)
        cellBody.lineBreakMode = .byWordWrapping
        cellBody.numberOfLines = 0
        let titlestack = UIStackView(arrangedSubviews: [cellTitle, cellBody])
        titlestack.axis = .vertical
        titlestack.spacing = 4

        cellSource.font = UIFont(name: "Arial", size: 8)
        cellSource.textAlignment = .right
        let footerStack = UIStackView(arrangedSubviews: [UIView(), cellSource])
        
        let mainStack = UIStackView(arrangedSubviews: [titlestack, UIView(), footerStack])
        mainStack.axis = .vertical
        mainStack.spacing = 8
    
        contentView.addSubview(mainStack)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 1
        
        addViewConstraints(mainView: contentView, subView: mainStack, top: 8, left: 8, btm: -8, right: -8)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(newsTitle: String, newsBody: String, newsUrlLink: String, newsSource: String) {
        cellTitle.text = String(newsTitle)
        cellBody.text = String(newsBody)
        cellLink = String(newsUrlLink)
        cellSource.text = String("source: " + newsSource)
   }
}
