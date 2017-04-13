//
//  Reducers.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/13.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import Foundation
import ReSwift

// MARK: TabBarReducer

struct TabBarReducer{}
extension TabBarReducer: Reducer{
    func handleAction(action: Action, state: AppState?) -> AppState {
        let state=state ?? AppState()
        var newState=state
        var tabBarState=newState.tabBar
        
        switch action {
        case let action as TabBarState.UpdateTabIndex:
            tabBarState.tabIndex=action.tabIndex
            break
        default:
            break
        }
        newState.tabBar=tabBarState
        return newState
    }
}
