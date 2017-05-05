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
        
        showPageViewWithCollectionView()
        
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
    
    fileprivate func showPageViewWithCollectionView() {
        
        //系统会自动给scrollView添加内边距，建议加上这一句
        automaticallyAdjustsScrollViewInsets = false
        
        let titles = ["主题", "pp", "qqqq", "wwww"];
        let style = ZYTitleStyle()
        style.isShowScrollLine = true
        
        let layout = ZYPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.cols = 7
        layout.rows = 3
        
        let pageFrame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        let pageCollectionView = ZYPageCollectionView(frame: pageFrame, titles: titles, isTitleInTop: false, style: style, layout: layout)
        pageCollectionView.registerCellClass(UICollectionViewCell.self, identifier: kPageCollectionViewIdentity)
        pageCollectionView.dataSource = self
        view.addSubview(pageCollectionView)
    }
}

extension ViewController: ZYPageCollectionViewDataSource {
    func numberOfSection(in pageCollectionView: ZYPageCollectionView) -> Int {
        return 4
    }
    
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random_uniform(30) + 30)
    }
    
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCollectionViewIdentity, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}

