//
//  ZYTitleView.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

protocol ZYTitleViewDelegate: class {
    func titleView(_ titleView: ZYTitleView, targetIdx: Int)
    
}

class ZYTitleView: UIView {

    weak var delegate: ZYTitleViewDelegate?
    
    fileprivate var titles: [String]
    fileprivate var style: ZYTitleStyle
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.scrollLineColor
        bottomLine.frame.size.height = self.style.scrollLineH
        bottomLine.frame.origin.y = self.bounds.height - self.style.scrollLineH
        return bottomLine
    }()
    
    fileprivate lazy var titleLabs: [UILabel] = [UILabel]()
    
    fileprivate var currentIdx: Int = 0
    
    
    
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
        
        if style.isShowScrollLine {
            scrollView.addSubview(bottomLine)
        }
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
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(clickTitleLabel(_:)))
            lab.addGestureRecognizer(recognizer)
            lab.isUserInteractionEnabled = true
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
                    if style.isShowScrollLine {
                        bottomLine.frame.origin.x = x
                        bottomLine.frame.size.width = w
                    }
                }
            }
            else {
                
                w = bounds.width / CGFloat(titleLabs.count)
                x = CGFloat(i) * w
                if i == 0 && style.isShowScrollLine {
                    bottomLine.frame.origin.x = 0
                    bottomLine.frame.size.width = w
                }
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabs.last!.frame.maxX + style.titleMargin * 0.5, height: 0) : CGSize.zero
        
    }
}

extension ZYTitleView: ZYContainViewDelegate {
    
    func containView(_ containView: ZYContainView, targetIdx: Int) {
        
        
        currentIdx = targetIdx
        adjustTitleLab(sourceLab: titleLabs[currentIdx], targetLab: titleLabs[targetIdx])
    }
    
    func containView(_ containView: ZYContainView, targetIdx: Int, sourceIdx: Int, progress: CGFloat) {
        
        
        let targetLab = titleLabs[targetIdx]
        let sourceLab = titleLabs[sourceIdx]
        
//        print("\(sourceIdx)    \(targetIdx)")
        currentIdx = targetIdx
        // 颜色渐变
        let deltaRGB = UIColor.getRGBDelta(style.selectedColor, style.normalColor)
        let selectRGB = style.selectedColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        
        sourceLab.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        targetLab.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        
        
        //计算滚动的范围差值
        let moveTotalX = targetLab.frame.origin.x - sourceLab.frame.origin.x
        let moveTotalW = targetLab.frame.width - sourceLab.frame.width
        
        if style.isShowScrollLine {
            bottomLine.frame.size.width = sourceLab.frame.width + moveTotalW * progress
            bottomLine.frame.origin.x = sourceLab.frame.origin.x + moveTotalX * progress
        }
        
    }
}

// MARK: - 事件监听
extension ZYTitleView {
    @objc fileprivate func clickTitleLabel(_ recognizer: UITapGestureRecognizer) {
        let targetLab = recognizer.view as! UILabel
        let sourceLab = titleLabs[currentIdx]
        
        if style.isShowScrollLine {
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomLine.frame.origin.x = targetLab.frame.origin.x
                self.bottomLine.frame.size.width = targetLab.frame.width
            })
        }
        
        adjustTitleLab(sourceLab: sourceLab, targetLab: targetLab)
        
        delegate?.titleView(self, targetIdx: currentIdx)
    }
    
    fileprivate func adjustTitleLab(sourceLab: UILabel, targetLab: UILabel) {
        
        sourceLab.textColor = style.normalColor
        targetLab.textColor = style.selectedColor
        
        currentIdx = targetLab.tag
        
        delegate?.titleView(self, targetIdx: currentIdx)
        
        
        if style.isScrollEnable {  //调整label的滚动位置到屏幕中间
            var offsetX: CGFloat = targetLab.center.x - scrollView.bounds.width * 0.5
            
            if offsetX < 0 {
                offsetX = 0
            }
            
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: true)
        }
        
        
    }
}

