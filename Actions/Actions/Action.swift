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


public func action<I,O>(_ a: AnAction<I, O>.Type, _ input:I) -> O {
    let anAction = Actions.get(a)
    return action(anAction, input)
}

public func action<T:Action>(_ userAction: T?, _ input:T.Input) -> T.Output {
    return userAction!.perform(input)
}

public func action<T:Action>(_ userAction: T?) -> T.Output where T.Input == Void {
    return userAction!.perform(())
}


// Injection
import Swinject

public class Actions {
    
    static let container = Container()
    
    public static func plug<I,O>(_ action: AnAction<I, O>.Type, to implementation:AnAction<I, O>) {
        container.register(action) { _ in
            return implementation
        }
    }
    
    public static func plug<I,O>(_ action: AnyAction<I, O>.Type, to implementation:AnyAction<I, O>) {
        container.register(action) { _ in
            return implementation
        }
    }
    
    public static func get<I,O>(_ action: AnAction<I, O>.Type) -> AnAction<I, O> {
       return container.resolve(action)!
    }
}



open class AnAction<Input, Output>: Action {
    
    public init() {}
    
    var _perform:( (Input) -> Output)!
    
    public init<T:Action>(_ action:T) where T.Output == Output, T.Input == Input {
        _perform = action.perform
    }
    
    open func perform(_ input: Input) -> Output {
        return _perform(input)
    }
}
