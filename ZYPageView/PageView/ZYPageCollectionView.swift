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

@objc protocol ZYPageCollectionViewDelegate : class {
    @objc optional func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, didSelectItemAt indexPath: IndexPath)
}

class ZYPageCollectionView: UIView {

    weak var dataSource: ZYPageCollectionViewDataSource?
    weak var delegate: ZYPageCollectionViewDelegate?
    
    var titles: [String]
    var isTitleInTop: Bool
    var style: ZYTitleStyle
    var layout: ZYPageCollectionViewLayout
    var sourceIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var titleView: ZYTitleView!
    
    
    
    init(frame: CGRect, titles: [String], isTitleInTop: Bool = true, style: ZYTitleStyle, layout: ZYPageCollectionViewLayout) {
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
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - 设置UI
extension ZYPageCollectionView {
    fileprivate func setupUI() {
        let titleViewY = isTitleInTop ? 0 : bounds.height - style.titleViewH
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleViewH)
        titleView = ZYTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.delegate = self
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
        let pageControlH: CGFloat = 20
        let pageControlY = isTitleInTop ? (bounds.height - pageControlH) : (bounds.height - style.titleViewH - pageControlH)
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlH)
        pageControl = UIPageControl(frame: pageControlFrame)
    
        pageControl.backgroundColor = UIColor.gray
        addSubview(pageControl)
        
        let collectionViewY = isTitleInTop ? style.titleViewH : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleViewH - pageControlH)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.black
        addSubview(collectionView)
        
    }
}


// MARK: - UICollectionViewDataSource
extension ZYPageCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource?.numberOfSection(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
        
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
        }
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}



// MARK: - 处理滚动逻辑
extension ZYPageCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView!(self, didSelectItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    
    /// 处理滚动结束
    fileprivate func scrollViewEndScroll() {
        //首先，可以拿到当前屏幕上的一个point，然后根据这个point取到对应cell的indexPath，需要注意的是，要确保这个point的位置是在某个cell上面的
        let point = CGPoint(x: layout.sectionInset.left + 1 + collectionView.contentOffset.x, y: layout.sectionInset.top + 1 + collectionView.contentOffset.y)
        guard let indexPath = collectionView.indexPathForItem(at: point) else{
            print("----------\(point)")
            return
        }
        
        if indexPath.section != sourceIndexPath.section {
            //这一组有个cell
            let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 1
            //这一组页数
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
            
//            print(pageControl.numberOfPages)
            
            titleView.setTitleWithSourceIndex(sourceIndexPath.section, targetIndex: indexPath.section, progress: 1)
            
            sourceIndexPath = indexPath
        }
        
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
    
}


extension ZYPageCollectionView: ZYTitleViewDelegate {
    func titleView(_ titleView: ZYTitleView, targetIdx: Int) {
        let indexPath = IndexPath(item: 0, section: targetIdx)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
        let sectionCount = self.dataSource?.numberOfSection(in: self) ?? 0
        
        if targetIdx != sectionCount - 1 {
            collectionView.contentOffset.x -= layout.sectionInset.left
        }
        
        self.scrollViewEndScroll()
    }
}
