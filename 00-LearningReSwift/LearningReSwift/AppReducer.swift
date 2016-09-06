//
//  AppReducer.swift
//  LearningReSwift
//
//  Created by Or on 06/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer: Reducer {
    
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        switch action {
        case let action as AddTask:
            state.list[0].insert(action.task, atIndex: 0)
        case let action as Reorder:
            let item = state.list[action.index.section].removeAtIndex(action.index.row)
            state.list[action.newIndex.section].insert(item, atIndex:action.newIndex.row)
            
        default:
            break
        }
        return state
    }
    
}