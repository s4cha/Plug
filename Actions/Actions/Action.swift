//
//  Action.swift
//  Actions
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public protocol Action {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Output
}

// Type-Erased Action
public struct AnyAction<Input, Output>: Action {
    
    var _perform: (Input) -> Output
    
    public init<T:Action>(_ action:T) where T.Output == Output, T.Input == Input {
        _perform = action.perform
    }
    
    public func perform(_ input: Input) -> Output {
        return _perform(input)
    }
}

public func action<T:Action>(_ userAction: T?, _ input:T.Input) -> T.Output {
    return userAction!.perform(input)
}

public func action<T:Action>(_ userAction: T?) -> T.Output where T.Input == Void {
    return userAction!.perform(())
}
