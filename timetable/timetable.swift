//
//  timetable.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/06.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation

class Timetable{
    // MARK: Properties
    var subject:String?
    var teacher:String?
    var place: String?
    // MARK: Initialization
    init?(subject:String?,teacher: String?,place:String?) {
        self.subject=subject
        self.teacher=teacher
        self.place=place
    }
}
