//
//  AppDelegate.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/28.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //设置全局属性
        setupGlobalAttribute()
        
        return true
    }
}

//MARK:- 设置全局属性
extension AppDelegate{
    
    func setupGlobalAttribute()  {
        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(UIImage(named: "Img_orange"), for: .default)
        
    }
    
    
    
}

