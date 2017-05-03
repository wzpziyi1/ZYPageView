//
//  ZYPageCollectionViewLayout.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/5/4.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYPageCollectionViewLayout: UICollectionViewFlowLayout {
    var rows: Int = 3
    var cols: Int = 4
    
    fileprivate var maxWidth: CGFloat = 0
    fileprivate lazy var cellAttrs = [UICollectionViewLayoutAttributes]()
}

extension ZYPageCollectionViewLayout {
    override func prepare() {
        
        /// 计算item宽度&高度
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        
        
        /// 一共有多少组cell
        let sectionNum = collectionView!.numberOfSections
        
        //需要统计此页之前有多少页，用来计算当前改摆放cell的x值
        var prePageNum: Int = 0
        
        //每一组有多少个cell，以及每个cell显示在collectionView的位置计算
        for i in 0..<sectionNum {
            //每组有多少个item
            let itemNum = collectionView!.numberOfItems(inSection: i)
            
            for j in 0..<itemNum {
                let indexPath = IndexPath(item: j, section: i)
                
                /// 创建对应indexpath的attribute
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 计算j在该组中第几页，该页中第多少个
                let page = j / (cols * rows)
                let index = j % (cols * rows)
                
                // 设置attr的frame
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                let itemX = CGFloat(prePageNum + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                cellAttrs.append(attribute)
            }
            prePageNum += (itemNum - 1) / (cols * rows) + 1
        }
        
        maxWidth = CGFloat(prePageNum) * collectionView!.bounds.width
    }
}


extension ZYPageCollectionViewLayout {
    
    /// 刷新布局
    ///
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
}


extension ZYPageCollectionViewLayout {
    
    /// 设置ContentSize
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }
}
