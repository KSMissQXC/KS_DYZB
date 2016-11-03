//
//  KSHomeController.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/28.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit


//MARK: - 常量
private let kTitleViewH : CGFloat = 40

class KSHomeController: UIViewController {
    
    //MARK: - 属性
    lazy var pagetTilteView : KSPageTitleView = {[weak self] in
       
        let titleFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH, width: KScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","游玩"]
        
        let titleView = KSPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContenView : KSPageContentView = {
        
        //确定内容的Frame
        let contentH = KScreenH - KStatusBarH - KNavigationBarH - kTitleViewH - KTabBarH
        let contentFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH + kTitleViewH, width: KScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(KSRecommendController())
        childVcs.append(UIViewController())
        childVcs.append(UIViewController())
        childVcs.append(UIViewController())
        
        let pageContentView = KSPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
    
        return pageContentView
        
        }()
    
    
    
    //MARK: - 方法
    //设在状态栏为白色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }

}


//MARK: - 设置UI界面
extension KSHomeController{
    func setupUI(){
        view.addSubview(pagetTilteView)
        view.addSubview(pageContenView)
    }
}

//MARK: - 设置代理方法
extension KSHomeController: KSPageTitleViewDelegate,KSPageContentViewDelegate{
    func pageTileView(_ titleView: KSPageTitleView, _ clickTitleIndex: Int) {
        pageContenView.setCurrentIndex(clickTitleIndex)
        
    }
    
    func pageContentView(_ contentView: KSPageContentView, _ scroProgess: CGFloat, _ sourceIndex: Int, _ targetIndex: Int) {
        
        pagetTilteView.setTitleWithProgress(scroProgess, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
        
    }
    
}
















