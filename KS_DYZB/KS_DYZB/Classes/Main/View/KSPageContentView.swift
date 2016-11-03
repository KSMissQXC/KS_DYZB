//
//  KSPageContentView.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/28.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit


// MARK:- 定义协议
protocol KSPageContentViewDelegate : class{
    func pageContentView(_ contentView : KSPageContentView,_ scroProgess : CGFloat,_ sourceIndex : Int,_ targetIndex : Int)

}


// MARK:- 定义常量
private let CotentCellID = "CotentCellID"

class KSPageContentView: UIView {
    // MARK:- 定义属性
    fileprivate   var  childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CotentCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : KSPageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false



    
    

    // MARK:- 自定义构造函数
    init(frame: CGRect,childVcs : [UIViewController],parentViewController : UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension KSPageContentView{
    fileprivate func setupUI() {
        // 1.将所有的子控制器添加父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds

    }
}



// MARK:- 代理方法
//MARK: collectionViewDelegate
extension KSPageContentView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:CotentCellID , for: indexPath)
        
        //2.给cell设置内容
        for view in collectionViewCell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        if !childVc.isViewLoaded {
            childVc.view.frame = collectionViewCell.contentView.bounds
//            childVc.view.backgroundColor = UIColor.randomColor()
        }
      
        collectionViewCell.contentView.addSubview(childVc.view)
        return collectionViewCell
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        //设置一些常量
        //滚动的进度
        var scrollProgress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            // 1.计算progress
            scrollProgress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)

            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                scrollProgress = 1
                targetIndex = sourceIndex
            }
        }else{// 右滑
            // 1.计算progress
            scrollProgress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))

            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentView(self, scrollProgress, sourceIndex, targetIndex)
    }
    
    
    
    
    
    
    
    
    
    
    

}

//MARK:- 暴露外界方法
extension KSPageContentView{
    func setCurrentIndex(_ currentIndex : Int){
        //需要滚动到的位置
        
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX,y: 0), animated: false)
    }
    
}

















