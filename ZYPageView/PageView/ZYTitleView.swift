//
//  ZYTitleView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYTitleView: UIView {

    fileprivate var titles: [String]
    fileprivate var style: ZYTitleStyle
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var titleLabs: [UILabel] = [UILabel]()
    
    init(frame: CGRect, titles: [String], style: ZYTitleStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ZYTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        
        setupTitleLabs()
        
        setupSubviewsFrame()
    }
    
    fileprivate func setupTitleLabs() {
        
        for (i, title) in titles.enumerated() {
            
            let lab = UILabel()
            lab.textAlignment = NSTextAlignment.center
            lab.text = title
            lab.font = UIFont.systemFont(ofSize: style.fontSize)
            lab.textColor = i == 0 ? style.selectedColor : style.normalColor
            lab.tag = i
            scrollView.addSubview(lab)
            titleLabs.append(lab)
        }
    }
    
    fileprivate func setupSubviewsFrame() {
        
        for (i, label) in titleLabs.enumerated() {
            var x: CGFloat = 0
            let y: CGFloat = 0
            var w: CGFloat = 0
            let h: CGFloat = style.titleViewH
            
            if style.isScrollEnable {   //如果可以滚动
                
                w = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil).size.width
                
                if i != 0 {
                    let preLabel = titleLabs[i - 1]
                    x = preLabel.frame.maxX + style.titleMargin
                }
                else {
                    x = style.titleMargin * 0.5
                }
            }
            else {
                
                w = bounds.width / CGFloat(titleLabs.count)
                x = CGFloat(i) * w
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabs.last!.frame.maxX + style.titleMargin * 0.5, height: 0) : CGSize.zero
        
    }
}
