//
//  TimetableAccessor.swift
//  timetable
//
//  Created by 森田一世 on 2017/05/17.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import RealmSwift
import RxRealm



class TimetableAccessor {
    static let sharedInstance=TimetableAccessor()
    
    typealias WholeTimetable = [Week:[TimetableEntity]]
    
    private let disposeBag=DisposeBag()
    
    private var timetableEntityNotificationToken:NotificationToken?=nil
    
    private var eachDaytimetableNotificationToken:NotificationToken?=nil
    
    private let realm:Realm
    
    private let wholeTimetableSubject=BehaviorSubject<[TimetableEntity]>(value: [TimetableEntity]())
    
    var wholeTimetablesVariable: Observable<WholeTimetable>{
        var aa:WholeTimetable=[:]
        for day in Week.Weeks{
            aa[day]=(0..<EachDayRange.MAX).map{
                TimetableEntity(dayEnum:day, hour:Int8($0),subject: "", teacher: "", place: "")
            }
        }
        return wholeTimetableSubject.filter{!$0.isEmpty}.scan(aa){
            var acc=$0
            print($1)
            for data in $1 {
                acc[data.dayEnum]?[Int(data.hour)]=data
            }
            return acc
        }.shareReplay(1).startWith(aa)
    }
    private init() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
        
        self.timetableEntityNotificationToken=realm.objects(TimetableEntity.self).addNotificationBlock{
            [weak self] (changes: RealmCollectionChange) in
            switch changes{
            case .initial(let value):
                self?.wholeTimetableSubject.onNext(value.toArray())
                value.forEach{
                    print("tasks,",$0.taskList)
                }
            case .update(let value,deletions: _,let insertions,let modifications):
                self?.wholeTimetableSubject.onNext(insertions.map{
                    print("inserted")
                    return value[$0]})
                self?.wholeTimetableSubject.onNext(modifications.map{
                    print("modified")
                    return value[$0]})
                
            case .error(let error):
                self?.wholeTimetableSubject.onError(error)
                fatalError("\(error)")
            }
        }
        
    }
    
    func set( data:TimetableEntity)->Observable<Void>{
        return Observable.create{
            obs in
            
            do{
                data.idSet()
                try self.realm.write {
                    self.realm.add(data, update: true)
                }
                obs.onNext()
                obs.onCompleted()
            }
            catch{
                obs.onError(error)
            }
            
            return Disposables.create {}
        }
    }
    deinit {
        timetableEntityNotificationToken?.stop()
    }
}






