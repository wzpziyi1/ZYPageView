# ZYPageView

框架的所有代码都在PageView这个文件夹里面，其他的代码只是编写UI

###1、左右滚动的选项卡界面

<img src="http://images2015.cnblogs.com/blog/471463/201706/471463-20170621170807679-1371528205.gif" alt="">

只需要在vc里面这么设置即可：

<pre>
    fileprivate func showPageViewWithVcs() {
        //创建titles数组
        let titles = ["主题", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "主题", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦", "wwwwwww", "吾问无为谓", "噢噢噢噢哦哦哦"]

        //        let titles = ["主题", "主题", "主题", "主题"];
        var vcs: [UIViewController] = []
        
        //添加子vc
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            vcs.append(vc)
        }

        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        //设置样式、具体样式在文件里面有注释
        let style = ZYTitleStyle()
        style.isScrollEnable = true
        let pageView = ZYPageView(frame: frame, titles: titles,childVcs: vcs, fatherVc: self, style: style)
        view.addSubview(pageView)
    }
</pre>


###2、表情键盘

<img src="http://images2015.cnblogs.com/blog/471463/201706/471463-20170621170835773-1554342356.gif" alt="">

这里我是在demo里面有了一个ZYEmotionView文件，里面是一些UI的编写，以及如何调用框架方法。

<pre>

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
</pre>
