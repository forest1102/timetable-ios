//
//  TabBarSetting.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/20.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class TabBarSetting{
    // MARK: Instance
    static let sharedInstance=TabBarSetting()
    let disposeBag=DisposeBag()
    // MARK: Variables
    let selectedBackgroundVariable=Variable<UIColor>(UIColor.white)
    let selectedTextColorVariable=Variable<UIColor>(UIColor.white)
    
    let tabBarColorVariable=Variable<UIColor>(UIColor.hexStr(hexStr: "#16244e", alpha: 1))
    let UnselectedTextColorVariable=Variable<UIColor>(UIColor.white)
    // MARK: Initialization
    init() {
        setup()
    }
    
    // MARK: setup method
    private func setup(){
        UnselectedTextColorVariable.asObservable()
            .bindTo(selectedBackgroundVariable)
            .addDisposableTo(disposeBag)
        
        tabBarColorVariable.asObservable()
        .bindTo(selectedTextColorVariable)
        .addDisposableTo(disposeBag)
    }
}
