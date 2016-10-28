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
    lazy var pagetTilteView : KSPageTitleView = {
       
        let titleFrame = CGRect(x: 0, y: KStatusBarH + KNavigationBarH, width: KScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","游玩"]
        
        let titleView = KSPageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.red
        return titleView
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
        
        
    }
}















