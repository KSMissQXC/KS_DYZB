//
//  KSRecommendController.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

//定义常量
private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50
let kNormalItemW = (KScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
private let kCycleViewH = KScreenW * 3 / 8



private let normalCell = "normalCell"
private let beautifyCell = "beautifyCell"


private let headerID = "headerID"


class KSRecommendController: UIViewController {

    //MARK: 定义属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
         collectionView.register(UINib.init(nibName: "KSHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: normalCell)
         collectionView.register(UINib.init(nibName: "KSHomeBeautifyCollectionCell", bundle: nil), forCellWithReuseIdentifier: beautifyCell)

        collectionView.register(UINib.init(nibName: "KSHomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionView
    }()
    
    fileprivate lazy var cycleView : KSHomeRecommendCycleView = {
        let cycleView = KSHomeRecommendCycleView.homeRecommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: KScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    var recommendVM = KSRecommendViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        loadData()
        
     
       
        
        
        
    }

}

//MARK:- 设置UI界面
extension KSRecommendController{
    func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH , left: 0, bottom: 0, right: 0)

    }
}

//MARK:- 加载网络数据
extension KSRecommendController{
    func loadData() {
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
        
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }

        
    }
}











//MARK:- 代理方法
extension KSRecommendController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        if indexPath.section == 1 {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: beautifyCell, for: indexPath) as! KSHomeBeautifyCollectionCell
            cell.anchorModel = anchor;

            return cell

        }else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCell, for: indexPath) as! KSHomeCollectionViewCell
            cell.anchorModel = anchor
            return cell

        }
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! KSHomeCollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
    
    
    
    
    
}











