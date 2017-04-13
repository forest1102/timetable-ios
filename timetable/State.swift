//
//  State.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/13.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import ReSwift

// MARK: AppState
struct AppState:StateType{
    var tabBar=TabBarState()
}

struct TabBarState:StateType {
    var tabIndex:Int=0
    var tabNames=["Mon","Tue","Wed","Thu","Wed"]
}

