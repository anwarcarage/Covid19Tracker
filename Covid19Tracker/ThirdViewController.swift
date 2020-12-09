//
//  ThirdViewController.swift
//  Covid19Tracker
//
//  Created by user162990 on 12/1/20.
//  Copyright © 2020 Tim Nanney. All rights reserved.
//

import UIKit

class NewsData: NSObject {
    let newsTitle: String
    let commentCount: Int
    let comments: String
    let timeStamp: String

    init(newsTitle: String,
        commentCount: Int,
        comments: String,
        timeStamp: String) {
        self.newsTitle = newsTitle
        self.commentCount = commentCount
        self.comments = comments
        self.timeStamp = timeStamp
    }
}

class ThirdViewController: UIViewController {
    
    let newsFeed: [NewsData] = [
            NewsData(newsTitle: "Cognitive Distortions of People Who Get Stuff Done [pdf]", commentCount: 43, comments: "comments", timeStamp: "138 points by bleigh0 2 hours ago"),
            NewsData(newsTitle: "Testing 1 2 3", commentCount: 43, comments: "comments", timeStamp: "138 points by bleigh0 2 hours ago"),
            NewsData(newsTitle: "Cognitive Distortions of People Who Get Stuff Done [pdf]", commentCount: 43, comments: "comments", timeStamp: "138 points by bleigh0 2 hours ago"),
            NewsData(newsTitle: "Cognitive Distortions of People Who Get Stuff Done [pdf]", commentCount: 43, comments: "comments", timeStamp: "138 points by bleigh0 2 hours ago"),
        
        ]
    
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

            let width = UIScreen.main.bounds.width - 32

            let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: width, height: 80)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumInteritemSpacing = 0
                flowLayout.minimumLineSpacing = 0

            collectionView.setCollectionViewLayout(flowLayout, animated: false)
            
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.delegate = self

            // everyone forgets this
            collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")

            view.addSubview(collectionView)

            addViewConstraints(mainView: view, subView: collectionView, top: 0, left: 0, btm: 0, right: 0)

            navigationItem.title = "News Flash"

        }
    }

    extension ThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return newsFeed.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? NewsCell

            let news = newsFeed[indexPath.row]
                cell?.update(
                    newsTitle: news.newsTitle,
                    commentCount: news.commentCount,
                    comment: news.comments,
                    timeStamp: news.timeStamp
            )

            return cell ?? UICollectionViewCell()
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
       let cellCommentCount = UILabel()
       let cellComment = UILabel()
       let cellTimeStamp = UILabel()

        override init(frame: CGRect) {
            super.init(frame: frame)
            
            let titlestack = UIStackView(arrangedSubviews: [cellTitle, cellTimeStamp])
            titlestack.axis = .vertical
            titlestack.spacing = 4
            
            let commentstack = UIStackView(arrangedSubviews: [cellCommentCount, cellComment])
            commentstack.axis = .vertical
            commentstack.spacing = 4
            commentstack.translatesAutoresizingMaskIntoConstraints = false
            commentstack.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            let hstack = UIStackView(arrangedSubviews: [titlestack, commentstack])
            hstack.axis = .horizontal
            hstack.spacing = 8
            hstack.alignment = .center
        
            cellTitle.numberOfLines = 3
            cellTitle.lineBreakMode = .byWordWrapping
            cellCommentCount.textAlignment = .center
            cellComment.textAlignment = .center
            
            contentView.addSubview(hstack)
            
            addViewConstraints(mainView: contentView, subView: hstack, top: 0, left: 8, btm: 0, right: -8)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update(newsTitle: String, commentCount: Int, comment: String, timeStamp: String) {
            cellTitle.text = String(newsTitle)
            cellCommentCount.text = String(commentCount)
            cellComment.text = String(comment)
            cellTimeStamp.text = String(timeStamp)
       }
}
