//
//  SchoolTaskEntity.swift
//  timetable
//
//  Created by 森田一世 on 2017/06/10.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RealmSwift

class SchoolTaskEntity: Object {
    dynamic var timetableInfo:TimetableEntity? = TimetableEntity()
    dynamic var deadline      = NSDate()
    dynamic var name          = ""
    dynamic var memo          = ""
}
