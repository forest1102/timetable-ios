//
//  DayTabBarItems.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/17.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WeekOfDay{
    //MARK: Instance
    static let sharedInstance=WeekOfDay()
    // MARK: Enum
    enum Week:Int {
        case Mon=0,Tue,Wed,Thu,Fri,Sat,Sun
        static let Weeks:[WeekOfDay.Week]=[.Mon,.Tue,.Wed,.Thu,.Fri,.Sat,.Sun]
    }
    enum ShowKind: Int{
        case Short,Initial,Japanese
    }
    private static let WeekNameList:[ShowKind:[String]]=[
        .Short: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
        .Initial: ["M","T","W","T","F","S","S"],
        .Japanese: ["月","火","水","木","金","土","日"],
        ]
    // MARK: Variables
    let rangeWeekVariable = Variable<Week>(.Fri)
    let showKindVariable = Variable<ShowKind>(.Short)
    let curSelectedItem=Variable<Week>(.Mon)
    // MARK: Observables
    var WeekListObservable:Observable<[String]>!
    
    init() {
        setup()
    }
    
    private func setup(){
        WeekListObservable=Observable.combineLatest(
            rangeWeekVariable.asObservable().map{$0.rawValue},
            showKindVariable.asObservable() )
        {
            (range:Int,kind:ShowKind) in
            [String](WeekOfDay.WeekNameList[kind]![0...range])
        }
    }
}
