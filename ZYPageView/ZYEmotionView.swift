//
//  ZYEmotionView.swift
//  ZYPageView
//
//  Created by 王志盼 on 27/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

private let kEmotionCellIdentifier = "ZYEmotionCell"


class ZYEmotionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ZYEmotionView {
    fileprivate func setupUI() {
        //标题
        let titles = ["普通", "专属粉丝", "pp", "qq"];
        let style = ZYTitleStyle()
        style.isShowScrollLine = true
        
        //实例化表情界面
        let layout = ZYPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.cols = 7
        layout.rows = 3
        let pageCollectionView = ZYPageCollectionView(frame: bounds, titles: titles, isTitleInTop: false, style: style, layout: layout)
        
        //注册cell
        pageCollectionView.registerCellNib(UINib(nibName: kEmotionCellIdentifier, bundle: nil), identifier: kEmotionCellIdentifier)
        pageCollectionView.dataSource = self
        addSubview(pageCollectionView)
    }
}


// MARK: - ZYPageCollectionViewDataSource
extension ZYEmotionView: ZYPageCollectionViewDataSource {
    
    func numberOfSection(in pageCollectionView: ZYPageCollectionView) -> Int {
        return ZYEmotionVM.sharedEmotionVM.packages.count
    }
    
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Int(ZYEmotionVM.sharedEmotionVM.packages[section].emoticons.count)
        
    }
    
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, _ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmotionCellIdentifier, for: indexPath) as! ZYEmotionCell
        cell.emotionEntity = ZYEmotionVM.sharedEmotionVM.packages[indexPath.section].emoticons[indexPath.row]
        return cell
    }
}
