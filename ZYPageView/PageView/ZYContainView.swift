//
//  ZYContainView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

fileprivate let kContainCellID = "kContainCellID"

protocol ZYContainViewDelegate: class {
    func containView(_ containView: ZYContainView, targetIdx: Int)
    
    func containView(_ containView: ZYContainView, targetIdx: Int, sourceIdx: Int, progress: CGFloat)
}

class ZYContainView: UIView {
    
    weak var delegate: ZYContainViewDelegate?
    
    fileprivate var fatherVc: UIViewController
    fileprivate var childVcs: [UIViewController]
    fileprivate var startOffsetX: CGFloat = 0
    
    
    /// 是否禁止滚动，主要是点击事件的时候，不需要做处理
    fileprivate var isForbidScroll: Bool = false
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContainCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    init(frame: CGRect, fatherVc: UIViewController, childVcs: [UIViewController]) {
        self.fatherVc = fatherVc
        self.childVcs = childVcs
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 设置UI
extension ZYContainView {
    
    fileprivate func setupUI() {
        
        for vc in childVcs {
            fatherVc.addChildViewController(vc)
        }
        
        addSubview(collectionView)
    }
    
}

extension ZYContainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContainCellID, for: indexPath)
        let newView = childVcs[indexPath.row].view
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        cell.contentView.addSubview(newView!)
        newView?.frame = cell.contentView.bounds
        return cell
    }
    
}

extension ZYContainView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if startOffsetX == scrollView.contentOffset.x || isForbidScroll {   //如果初始移动的x值一样、或者禁止滚动
            return
        }
        
        // 定义targetIndex/progress
        var targetIndex = 0
        var progress : CGFloat = 0.0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        // 给targetIndex/progress赋值
        var currentIndex: Int = 0
        
        
        if startOffsetX < currentOffsetX { // 左滑动
            
            currentIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = currentIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            progress = currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width)
            
            //如果滚完一页
            if currentOffsetX - startOffsetX ==  scrollViewW {
                progress = 1
                targetIndex = currentIndex
            }
            
        } else { // 右滑动
            
            targetIndex = Int(currentOffsetX / scrollView.bounds.width)
            currentIndex = targetIndex + 1
            if currentIndex > childVcs.count - 1 {
                currentIndex = childVcs.count - 1
            }
            
            progress = 1 - (currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width))
            
        }
        
        // 通知代理，切换titleView文字的渐变
        delegate?.containView(self, targetIdx: targetIndex, sourceIdx: currentIndex, progress: progress)
    }
    
    private func contentEndScroll() {
        
        if isForbidScroll {
            return
        }
        
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        delegate?.containView(self, targetIdx: currentIndex)
        
        
    }
}

extension ZYContainView: ZYTitleViewDelegate {
    func titleView(_ titleView: ZYTitleView, targetIdx: Int) {
        
        isForbidScroll = true
        let indexPath = IndexPath(item: targetIdx, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        
    }
}
