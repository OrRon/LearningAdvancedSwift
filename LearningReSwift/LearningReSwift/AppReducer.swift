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
            state.tasklist.append(action.task)
        default:
            break
        }
        return state
    }
    
}