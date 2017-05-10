//
//  EachDayRange.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/30.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import RxSwift

class EachDayRange{
    static let sharedInstance=EachDayRange()
    static let MAX=12
    let currentVariable=Variable<Int>(6)
}
