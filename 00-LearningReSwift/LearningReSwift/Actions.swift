//
//  Actions.swift
//  LearningReSwift
//
//  Created by Or on 06/09/2016.
//  Copyright © 2016 Or. All rights reserved.
//

import Foundation
import ReSwift

struct AddTask: Action {
    // identifies the action
    let task: String
    // this flag is used for serialization when working with ReSwift Recorder
    let isTypedAction: Bool
    
}