//
//  KSHomeRecommendCycleView.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/3.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit


private let kCycleCellID = "kCycleCellID"


class KSHomeRecommendCycleView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    var cycleTimer : Timer?

    var cycleModels : [KSHomeCycleModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 3.默认滚动到中间某一个位置
//            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
//            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
         collectionView.register(UINib(nibName: "KSHomeRecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = collectionView.bounds.size
        
        
    }
    
    
    
 
}


// MARK:- 提供一个快速创建View的类方法
extension KSHomeRecommendCycleView{
   class func homeRecommendCycleView()  -> KSHomeRecommendCycleView {
        return Bundle.main.loadNibNamed("KSHomeRecommendCycleView", owner: nil, options: nil)?.first as! KSHomeRecommendCycleView
    }

    
}

// MARK:- 代理方法
extension KSHomeRecommendCycleView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! KSHomeRecommendCycleCell
        cell.cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
        return cell
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }

    
    
    
}


// MARK:- 对定时器的操作方法
extension KSHomeRecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}











