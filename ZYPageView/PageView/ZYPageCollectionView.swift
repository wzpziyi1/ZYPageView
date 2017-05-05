//
//  ZYPageCollectionView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/5/3.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit


protocol ZYPageCollectionViewDataSource: class {
    func numberOfSection(in pageCollectionView: ZYPageCollectionView) -> Int
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, numberOfItemsInSection section: Int) -> Int
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, _ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class ZYPageCollectionView: UIView {

    var dataSource: ZYPageCollectionViewDataSource?
    var titles: [String]
    var isTitleInTop: Bool
    var style: ZYTitleStyle
    var layout: UICollectionViewLayout
    
    var collectionView: UICollectionView!
    
    
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


// MARK: - 外面用的注册cell的方法
extension ZYPageCollectionView {
    
    func registerCellClass(_ cellClass: AnyClass?, identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellNib: UINib?, identifier: String) {
        collectionView.register(cellNib, forCellWithReuseIdentifier: identifier)
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
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.randomColor()
        addSubview(collectionView)
        
    }
}


// MARK: - UICollectionViewDataSource
extension ZYPageCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource?.numberOfSection(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}
