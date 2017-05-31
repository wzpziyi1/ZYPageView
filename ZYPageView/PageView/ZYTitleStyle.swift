//
//  ZYTitleStyle.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class  ZYTitleStyle {
    //标题高度
    var titleViewH: CGFloat = 44
    //字体大小
    var fontSize: CGFloat = 14
    //标题普通状态下颜色
    var normalColor: UIColor = UIColor(hex: "0x666666")!
    //标题选中状态下颜色
    var selectedColor: UIColor = UIColor.orange
    //标题是否可以滚动
    var isScrollEnable: Bool = false
    //titleView距离左边间距
    var titleMargin: CGFloat = 20
    
    //是否显示下面的滚动条
    var isShowScrollLine: Bool = true
    //滚动条高度
    var scrollLineH: CGFloat = 2
    //滚动条颜色
    var scrollLineColor: UIColor = UIColor.orange
    
}
