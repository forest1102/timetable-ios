//
//  SchoolTaskAccessor.swift
//  timetable
//
//  Created by 森田一世 on 2017/06/11.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
class SchoolTaskAccessor {

    // MARK: Properties
    
    static let sharedInstance=SchoolTaskAccessor()
    let realm:Realm
    
    // MARK: Initialization
    private init(){
        realm=try! Realm()
    }
    
    func set(week:Week,hour:Int8,task:SchoolTaskEntity)->Observable<SchoolTaskEntity>{
        return Observable.create{
            obs in
            do{
                let timetable=self.realm.object(ofType: TimetableEntity.self, forPrimaryKey: week.toString+"\(hour)")
                                ?? TimetableEntity(dayEnum: week, hour: hour, subject: "", teacher: "", place: "")
                task.timetableInfo=timetable
                try self.realm.write {
                    self.realm.add(task)
                }
                obs.onNext(task)
                obs.onCompleted()
            }
            catch{
                obs.onError(error)
            }
            return Disposables.create()
        }
    }
}
