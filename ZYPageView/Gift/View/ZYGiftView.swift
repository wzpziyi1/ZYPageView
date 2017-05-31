//
//  ZYGiftView.swift
//  ZYPageView
//
//  Created by 王志盼 on 31/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

private let kGiftViewCellIdentifier = "ZYGiftViewCell"

protocol ZYGiftViewDelegate: class {
    func giftListView(giftView : ZYGiftView, giftEntity : ZYGiftEntity)
}

class ZYGiftView: UIView {

    weak var delegate: ZYGiftViewDelegate?
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!

    fileprivate var pageCollectionView : ZYPageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
    fileprivate var giftVM : ZYGiftVM = ZYGiftVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
        loadGiftData()
    }
    
    
}


// MARK: - 点击事件
extension ZYGiftView {
    @IBAction func sendGiftBtnClick() {
        let package = giftVM.giftlistData[currentIndexPath!.section]
        let giftModel = package.list[currentIndexPath!.item]
        delegate?.giftListView(giftView: self, giftEntity: giftModel)
    }
}

// MARK: - 网络处理
extension ZYGiftView {
    
    fileprivate func loadGiftData() {
        giftVM.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
    
}

// MARK: - 加载UI
extension ZYGiftView {
    
    func setupUI() {
        //标题
        let titles = ["热门", "高级", "豪华", "专属"];
        
        let style = ZYTitleStyle()
        style.isScrollEnable = false
        style.isShowScrollLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = ZYPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = UIScreen.main.bounds.width
        
        pageCollectionView = ZYPageCollectionView(frame: bounds, titles: titles, isTitleInTop: false, style: style, layout: layout)
        
        //注册cell
        pageCollectionView.registerCellNib(UINib(nibName: kGiftViewCellIdentifier, bundle: nil), identifier: kGiftViewCellIdentifier)
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        addSubview(pageCollectionView)
    }
    
}





extension ZYGiftView: ZYPageCollectionViewDataSource, ZYPageCollectionViewDelegate {
    func numberOfSection(in pageCollectionView: ZYPageCollectionView) -> Int {
        print("----- \(giftVM.giftlistData.count)")
        return giftVM.giftlistData.count
    }
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = giftVM.giftlistData[section]
        return package.list.count
    }
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, _ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftViewCellIdentifier, for: indexPath) as! ZYGiftViewCell
        
        let package = giftVM.giftlistData[indexPath.section]
        cell.giftEntity = package.list[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: ZYPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}


