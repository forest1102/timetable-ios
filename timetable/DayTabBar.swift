//
//  DayTabBar.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/14.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit
//import ReSwift
import RxSwift
import RxCocoa
import os.log
class DayTabBar: UITabBar {
    private let disposeBag=DisposeBag()
    private let tabBarLabelSize:CGFloat=15.0
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeBar()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        customizeBar()
    }
    // MARK: Private Properties
    private func customizeBar(){
        UITabBarItem.appearance(whenContainedInInstancesOf: [DayTabBar.self]).setTitleTextAttributes(
            [
                NSFontAttributeName:UIFont.systemFont(ofSize: tabBarLabelSize),
                NSForegroundColorAttributeName:UIColor.white
            ], for: UIControlState.normal)
        UITabBarItem.appearance(whenContainedInInstancesOf: [DayTabBar.self]).titlePositionAdjustment=UIOffsetMake(0, -9)
        TabBarSetting.sharedInstance.tabBarColorVariable.asObservable()
            .subscribe(onNext:{
                [weak self] in
                self?.barTintColor=$0
            }).addDisposableTo(disposeBag)
    }
    
    func setUp(){
        let focusView=FocusView(frame:CGRect(origin:CGPoint(x:0.0,y:0.0),
                                             size: CGSize(width: self.bounds.width/5.0, height: self.bounds.height)))
        
        focusView.padding=UIEdgeInsets(top: 9, left: 0, bottom: 0, right: 0)
        focusView.font=UIFont.systemFont(ofSize: tabBarLabelSize)
        
        
        Observable.combineLatest(
            WeekOfDay.sharedInstance.WeekListObservable,
            WeekOfDay.sharedInstance.curSelectedItem.asObservable())
            {(weekList,selectedTag) in weekList[selectedTag.rawValue]}
            .subscribe(
                onNext:{
                    focusView.text=$0
            },onError:{print($0)})
            .addDisposableTo(disposeBag)
        
        WeekOfDay.sharedInstance.WeekListObservable
            .subscribe(
                onNext:{
                [weak self] weekList in
                self!.items=[]
                for (i,weekName) in weekList.enumerated(){
                    self!.items!.append(UITabBarItem(title: weekName, image: nil, tag: i))
                    }
            },
                onError:{print($0)})
            .addDisposableTo(disposeBag)
        
        self.rx.didSelectItem
            .map{WeekOfDay.Week(rawValue:$0.tag)!}
            .subscribe(onNext:{
                cur in
                focusView.text=""
                UIView.animate(withDuration: 0.1,delay:0.0,options:.curveEaseOut, animations: {
                    focusView.center.x=focusView.bounds.width*(0.5+CGFloat(cur.rawValue))
                }, completion: {
                    _ in
                    WeekOfDay.sharedInstance.curSelectedItem.value=cur
                })
                },
            onError:{print($0)})
        .addDisposableTo(disposeBag)
        
        self.addSubview(focusView)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
