//
//  TimetableAccessor.swift
//  timetable
//
//  Created by 森田一世 on 2017/05/17.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class TimetableAccessor {
    let realm = try! Realm()
    static let sharedInstance=TimetableAccessor()
    typealias WholeTimetable = [Week:[TimetableEntity]]
    
    let defaultTimetable:WholeTimetable
    private let wholeTimetableSubject:BehaviorSubject<WholeTimetable>
    
    var wholeTimetablesVariable: Observable<WholeTimetable>{
        return wholeTimetableSubject
    }
    
    init() {
        var aa:WholeTimetable=[:]
        for day in Week.Weeks{
            aa[day]=(0..<EachDayRange.MAX).map{
                TimetableEntity(dayEnum:day, hour:Int8($0),subject: "", teacher: "", place: "")
            }
        }
        defaultTimetable=aa
        wholeTimetableSubject=BehaviorSubject(value: aa)
    }
    
    func set( data:TimetableEntity){
        print(data)
        var timetables=try! self.wholeTimetableSubject.value()
        timetables[data.dayEnum]?[Int(data.hour)]=data
        self.wholeTimetableSubject.onNext(timetables)
    }
}






