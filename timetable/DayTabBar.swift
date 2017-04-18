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
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setUp()
    }
    
    // MARK: Private Properties
    private func setUp(){
        
        WeekOfDay.sharedInstance.WeekListObservable
            .subscribe(onNext:{
                [weak self] weekList in
                self?.items=[]
                for (i,weekName) in weekList.enumerated(){
                    self?.items?.append(UITabBarItem(title: weekName, image: nil, tag: i))
                }
                
            })
        
        self.rx.didSelectItem
            .map{WeekOfDay.Week(rawValue:$0.tag)!}
            .subscribe(onNext:{
            [weak self] in
                WeekOfDay.sharedInstance.curSelectedItem.value=$0
                
                print($0)
            })
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
