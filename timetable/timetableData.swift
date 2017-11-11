//
//  timetableData.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/17.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TimetableData {
    static let sharedInstance=TimetableData()
    //let TimetableAccessor.sharedInstance.wholeTimetablesVariable=Variable<[WeekOfDay.Week:[TimetableEntity]]>([:])
    var curTimetableDay:Observable<[TimetableEntity]>!
    init(){
        self.setup()
    }
    
    private func setup(){
        
        curTimetableDay=Observable.combineLatest(
            TimetableAccessor.sharedInstance.wholeTimetablesVariable.asObservable(),
            WeekOfDay.sharedInstance.curSelectedItem.asObservable(),
            EachDayRange.sharedInstance.currentVariable.asObservable())
        {
            (whole,item,range) in
            return [TimetableEntity](whole[item]![0..<range])
        }
    }
}
