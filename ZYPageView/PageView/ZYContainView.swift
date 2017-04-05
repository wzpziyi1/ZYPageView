//
//  ZYContainView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

fileprivate let kContainCellID = "kContainCellID"

class ZYContainView: UIView {
    
    fileprivate var fatherVc: UIViewController
    fileprivate var childVcs: [UIViewController]
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
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
