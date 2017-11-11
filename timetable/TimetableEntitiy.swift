//
//  TimetableEntitiy.swift
//  timetable
//
//  Created by 森田一世 on 2017/05/17.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
enum Week:Int {
    case Mon=0,Tue,Wed,Thu,Fri,Sat,Sun
    static let Weeks:[Week]=[.Mon,.Tue,.Wed,.Thu,.Fri,.Sat,.Sun]
    var toString:String{
        get{
            switch self {
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
            case .Sun: return "Sun"
            }
        }
    }
    init?(str:String){
        switch str {
        case "Mon": self = .Mon
        case "Tue": self = .Tue
        case "Wed": self = .Wed
        case "Thu": self = .Thu
        case "Fri": self = .Fri
        case "Sat": self = .Sat
        case "Sun": self = .Sun
        default: return nil
        }
    }
}


class TimetableEntity:Object {
    
    // MARK: Properties
    var dayEnum:Week{
        get{
            return Week(str: day)!
        }
        set{
            day = newValue.toString
        }
    }
    
    dynamic var hour:Int8=0
    dynamic var subject: String=""
    dynamic var teacher:String=""
    dynamic var place: String=""
    let taskList=LinkingObjects(fromType: SchoolTaskEntity.self, property: "timetableInfo")

    // MARK: Private Properties
    dynamic private var day:String = Week.Mon.toString
    dynamic private var id=""
    
    required convenience init(dayEnum:Week,hour:Int8,subject: String,teacher:String,place: String) {
        self.init()
        self.dayEnum=dayEnum
        self.hour=hour
        self.subject=subject
        self.teacher=teacher
        self.place=place
        self.idSet()
    }
    
    func idSet(){
        self.id=self.day+"\(self.hour)"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
