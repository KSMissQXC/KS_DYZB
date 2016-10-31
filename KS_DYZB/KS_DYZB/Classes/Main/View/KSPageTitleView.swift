//
//  KSPageTitleView.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/28.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit



// MARK:- 定义协议
protocol KSPageTitleViewDelegate : class{
    func pageTileView(_ titleView : KSPageTitleView ,_ clickTitleIndex : Int)
    
}


// MARK:- 定义常量
fileprivate let KScrollLineH : CGFloat = 2
fileprivate let KLineMargin : CGFloat = 5
private let KNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)




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
    
    weak var delegate : KSPageTitleViewDelegate?
    
   lazy fileprivate var labels : [UILabel] = [UILabel]()
    
    lazy fileprivate var scrollLineV : UIView = {
       let scroLine = UIView()
        scroLine.backgroundColor = UIColor.orange
        return scroLine
    }()
    
    fileprivate var currentIndex = 0
    
   
    
    //MARK:- 初始化方法
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
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            scrollView.addSubview(label)
            labels.append(label)
            
            if index == 0 {
                label.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        
        //保存现在的label的tag
        currentIndex = currentLabel.tag
        
        //滚动下面的滑条
        UIView.animate(withDuration: 0.15) { 
            self.scrollLineV.center.x = currentLabel.center.x
        }
        
        delegate?.pageTileView(self, currentIndex)
    }
}


// MARK:- 暴露外界方法
extension KSPageTitleView{
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int){
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalCenterX = targetLabel.center.x - sourceLabel.center.x
        let moveCenterX = moveTotalCenterX * progress
        scrollLineV.center.x = sourceLabel.center.x + moveCenterX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - KNormalColor.0, kSelectColor.1 - KNormalColor.1, kSelectColor.2 - KNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress)

//        //记录最新的index
        if progress == 1.0 {
            currentIndex = targetIndex
        }
        
        

        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
}










