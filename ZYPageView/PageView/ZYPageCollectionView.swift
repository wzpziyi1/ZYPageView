//
//  ZYPageCollectionView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/5/3.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

private let kPageCollectionViewIdentity = "kPageCollectionViewIdentity"

class ZYPageCollectionView: UIView {

    var titles: [String]
    var isTitleInTop: Bool
    var style: ZYTitleStyle
    var layout: UICollectionViewLayout
    
    
    init(frame: CGRect, titles: [String], isTitleInTop: Bool = true, style: ZYTitleStyle, layout: UICollectionViewLayout) {
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.style = style
        self.layout = layout
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI
extension ZYPageCollectionView {
    fileprivate func setupUI() {
        let titleViewY = isTitleInTop ? 0 : bounds.height - style.titleViewH
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleViewH)
        let titleView = ZYTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
        let pageControlH: CGFloat = 20
        let pageControlY = isTitleInTop ? (bounds.height - pageControlH) : (bounds.height - style.titleViewH - pageControlH)
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlH)
        let pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = UIColor.randomColor()
        addSubview(pageControl)
        
        let collectionViewY = isTitleInTop ? style.titleViewH : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleViewH - pageControlH)
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageCollectionViewIdentity)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.randomColor()
        addSubview(collectionView)
        
    }
}


// MARK: - UICollectionViewDataSource
extension ZYPageCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random_uniform(30)) + 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCollectionViewIdentity, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
