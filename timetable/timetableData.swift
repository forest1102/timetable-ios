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
    let wholeTimetablesVariable=Variable<[WeekOfDay.Week:[Timetable]]>([:])
    var curTimetableDay:Observable<[Timetable]>!
    init(){
        self.setup()
    }
    
    private func setup(){
        for day in WeekOfDay.Week.Weeks{
            wholeTimetablesVariable.value[day]=(0..<EachDayRange.MAX).map{
                _ in Timetable(subject: "", teacher: "", place: "")
            }
        }
        curTimetableDay=Observable.combineLatest(
            wholeTimetablesVariable.asObservable(),
            WeekOfDay.sharedInstance.curSelectedItem.asObservable(),
            EachDayRange.sharedInstance.currentVariable.asObservable())
        {
            (whole,item,range) in
            return [Timetable](whole[item]![0..<range])
        }
    }
}
