//
//  Action.swift
//  Actions
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public protocol ActionProtocol {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Output?
}

open class Action<I, O>: ActionProtocol {
    public init() {}
    open func perform(_ input: I) -> O? {
        return nil
    }
}

public func action<T:ActionProtocol>(_ actionType: T.Type, _ input:T.Input) -> T.Output {
    let a = Actions.get(actionType)
    return action(a, input)
}

public func action<T:ActionProtocol>(_ userAction: T?, _ input:T.Input) -> T.Output {
    return userAction!.perform(input)!
}

public func action<T:ActionProtocol>(_ actionType: T.Type) -> T.Output where T.Input == Void {
    let a = Actions.get(actionType)
    return action(a)
}

public func action<T:ActionProtocol>(_ userAction: T?) -> T.Output where T.Input == Void {
    return userAction!.perform(())!
}

// MARK: - Injections MGMT

public class Actions {
    
    public static let container = DependencyInjection()
    
    public static func plug<T:ActionProtocol>(_ action: T.Type, to implementation: @autoclosure @escaping () -> T) {
        container.register(action) { implementation() }
    }
    
    public static func get<T:ActionProtocol>(_ action: T.Type) -> T {
        return container.resolve(action)
    }
}

infix operator <~
public func <~ <T:ActionProtocol>(left: T.Type, right: @autoclosure @escaping () -> T) {
    Actions.plug(left, to: right())
}

// MARK: - DependencyInjection

public class DependencyInjection {
        
    private var storage = [String: () -> Any]()
    
    func register<T>(_ type: T.Type, block: @escaping () -> T) {
        storage[String(describing: type)] = block
    }
    
    func resolve<T>(_ type:T.Type? = nil) -> T {
        return storage[String(describing: type ?? T.self)]!() as! T
    }
}
