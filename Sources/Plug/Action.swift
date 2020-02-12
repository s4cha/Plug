//
//  Action.swift
//  Actions
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public protocol IsAction {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Output?
}

open class Action<I, O>: IsAction {
    public init() {}
    open func perform(_ input: I) -> O? {
        return nil
    }
}

public func action<T: IsAction>(_ actionType: T.Type, _ input:T.Input) -> T.Output {
    return action(Dependency.resolve(actionType), input)
}

public func action<T: IsAction>(_ userAction: T?, _ input:T.Input) -> T.Output {
    return userAction!.perform(input)!
}

public func action<T: IsAction>(_ actionType: T.Type) -> T.Output where T.Input == Void {
    return action(Dependency.resolve(actionType))
}

public func action<T: IsAction>(_ userAction: T?) -> T.Output where T.Input == Void {
    return userAction!.perform(())!
}


infix operator <~
public func <~ <T>(left: T.Type, right: @autoclosure @escaping () -> T) {
    Dependency.register(left, with: right)
}

public class DependencyContainer {
    
    private static let shared = DependencyContainer()
    private var storage = [String: () -> Any]()
    
    func register<T>(_ type: T.Type, with block: @escaping () -> T) {
        register(type, with: block())
    }

    func register<T>(_ type: T.Type, with block: @autoclosure @escaping () -> T) {
        storage[String(describing: type)] = block
    }

    func resolve<T>(_ type: T.Type? = nil) -> T {
        return storage[String(describing: type ?? T.self)]!() as! T
    }
}

// Nice static Api.

public typealias Dependency = DependencyContainer

public extension Dependency {
    static func register<T>(_ type: T.Type, with block: @escaping () -> T) {
        shared.register(type, with: block())
    }

    static func register<T>(_ type: T.Type, with block: @autoclosure @escaping () -> T) {
        shared.storage[String(describing: type)] = block
    }

    static func resolve<T>(_ type: T.Type? = nil) -> T {
        return shared.storage[String(describing: type ?? T.self)]!() as! T
    }
}
