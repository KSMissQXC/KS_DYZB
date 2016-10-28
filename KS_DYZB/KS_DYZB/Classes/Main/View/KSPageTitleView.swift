//
//  KSPageTitleView.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/28.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit


// MARK:- 定义常量
fileprivate let KScrollLineH : CGFloat = 2
fileprivate let KLineMargin : CGFloat = 5



class KSPageTitleView: UIView {
    
    //MARK:- 属性
    fileprivate var titles : [String]
    lazy fileprivate var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
   lazy fileprivate var labels : [UILabel] = [UILabel]()
    
    lazy fileprivate var scrollLineV : UIView = {
       let scroLine = UIView()
        scroLine.backgroundColor = UIColor.orange
        return scroLine
    }()
    
    fileprivate var currentIndex = 0
    
    
   
   
    
    //MARK:- 方法
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

//MARK:- 设置UI界面
extension KSPageTitleView{
    
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加所有label
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
        
        
        
    }
    
    fileprivate func setupTitleLabels(){
        //一些常量
        let titleCount = titles.count
        let labelW = frame.width / CGFloat(titleCount)
        let labelH = frame.height - KScrollLineH
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            let x = CGFloat(index) * labelW
            label.frame = CGRect(x: x, y: 0, width: labelW, height: labelH)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.isUserInteractionEnabled = true
            label.tag = index
            scrollView.addSubview(label)
            labels.append(label)
            
            if index == 0 {
                label.textColor = UIColor.orange
            }
            
            //给label添加手势
            let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(_ :)))
            
            label.addGestureRecognizer(labelTap)
 
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        
        //取出第一个label
        guard let firstLabel = labels.first else {
            return
        }
        
        //添加底部滚动线
        let scrollLineW = firstLabel.frame.width - 2 * KLineMargin;
        scrollLineV.frame = CGRect(x: KLineMargin, y: frame.height - KScrollLineH, width: scrollLineW, height: KScrollLineH)
        scrollView.addSubview(scrollLineV)
    }
}




// MARK:- 事件处理
extension KSPageTitleView{
    func labelClick(_ tapGes : UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        if currentIndex == currentLabel.tag {
            return
        }
        
        let oldLabel = labels[currentIndex]
        oldLabel.textColor = UIColor.black
        currentLabel.textColor = UIColor.orange
        
        //保存现在的label的tag
        currentIndex = currentLabel.tag
        
        //滚动下面的滑条
        UIView.animate(withDuration: 0.15) { 
            self.scrollLineV.center.x = currentLabel.center.x
        }
        
    }
    

}










