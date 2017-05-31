//
//  ViewController.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

private let kPageCollectionViewIdentity = "kPageCollectionViewIdentity"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showGiftView()
        
    }

    fileprivate func showPageViewWithVcs() {
        let titles = ["主题", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "主题", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦"]
        
        //        let titles = ["主题", "主题", "主题", "主题"];
        var vcs: [UIViewController] = []
        
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            vcs.append(vc)
        }
        
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        let style = ZYTitleStyle()
        style.isScrollEnable = true
        let pageView = ZYPageView(frame: frame, titles: titles,childVcs: vcs, fatherVc: self, style: style)
        view.addSubview(pageView)
    }
    
    
    /// 表情键盘
    fileprivate func showPageViewWithCollectionView() {
        
        //系统会自动给scrollView添加内边距，建议加上这一句
        automaticallyAdjustsScrollViewInsets = false
        
        let emotionView = ZYEmotionView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 300))
        emotionView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(emotionView)
    }
    
    
    /// 礼物键盘
    fileprivate func showGiftView() {
        automaticallyAdjustsScrollViewInsets = false
        
        let giftView = Bundle.main.loadNibNamed("ZYGiftView", owner: nil, options: nil)?.last as! ZYGiftView
        giftView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 320)
        giftView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(giftView)
    }
}

