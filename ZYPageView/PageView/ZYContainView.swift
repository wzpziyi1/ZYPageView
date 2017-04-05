//
//  ZYContainView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYContainView: UIView {
    
    fileprivate var fatherVc: UIViewController
    fileprivate var childVcs: [UIViewController]
    
    init(frame: CGRect, fatherVc: UIViewController, childVcs: [UIViewController]) {
        self.fatherVc = fatherVc
        self.childVcs = childVcs
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
