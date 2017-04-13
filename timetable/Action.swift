//
//  Action.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/13.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import ReSwift

// MARK: TabBarAction
extension TabBarState{
    struct UpdateTabIndex:Action {
        let tabIndex:Int
    }
    
}
