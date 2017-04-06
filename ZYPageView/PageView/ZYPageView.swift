//
//  ZYPageView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYPageView: UIView {

    fileprivate var titles: [String]
    fileprivate var childVcs: [UIViewController]
    fileprivate var fatherVc: UIViewController
    fileprivate var style: ZYTitleStyle
    
    fileprivate var titleView: ZYTitleView!
    init(frame: CGRect, titles: [String],childVcs: [UIViewController], fatherVc: UIViewController, style: ZYTitleStyle) {
        
        self.titles = titles
        self.childVcs = childVcs
        self.fatherVc = fatherVc
        self.style = style
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI
extension ZYPageView {
    fileprivate func setupUI() {
        setupTitleView()
        setupContainView()
    }
    
    fileprivate func setupTitleView() {
        titleView = ZYTitleView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewH), titles: titles, style: style)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
    }
    
    fileprivate func setupContainView() {
        let frame = CGRect(x: 0, y: style.titleViewH, width: bounds.width, height: bounds.height - style.titleViewH)
        let containView = ZYContainView(frame: frame, fatherVc: fatherVc, childVcs: childVcs)
        containView.backgroundColor = UIColor.randomColor()
        addSubview(containView)
    }
    
}
