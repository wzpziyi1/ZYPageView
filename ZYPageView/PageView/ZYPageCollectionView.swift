//
//  ZYPageCollectionView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/5/3.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYPageCollectionView: UIView {

    var titles: [String]
    var isTitleTop: Bool
    var style: ZYTitleStyle
    var layout: UICollectionViewLayout
    
    
    init(frame: CGRect, titles: [String], isTitleTop: Bool = true, style: ZYTitleStyle, layout: UICollectionViewLayout) {
        self.titles = titles
        self.isTitleTop = isTitleTop
        self.style = style
        self.layout = layout
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI
extension ZYPageCollectionView {
    fileprivate func setupUI() {
        
//        let titleView = ZYTitleView(frame: <#T##CGRect#>, titles: titles, style: style)
    }
}
