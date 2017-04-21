//
//  ViewController.swift
//  ZYPageView
//
//  Created by 王志盼 on 2017/4/5.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        automaticallyAdjustsScrollViewInsets = false
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

