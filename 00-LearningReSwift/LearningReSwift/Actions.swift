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
    let task: String
    let isTypedAction: Bool
}

struct Reorder: Action {
    let index: NSIndexPath
    let newIndex: NSIndexPath
}