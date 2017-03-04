//
//  MyWebApiActions.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import then
import ws
import Actions

var network: WS = {
    let ws = WS("https://jsonplaceholder.typicode.com")
    ws.logLevels = .debug
    return ws
}()

struct MyLikePhoto: Action {
    
    func perform(_ input: Photo) -> Promise<Void> {
        print("Like Photo")
        return network.post("/photos/\(input.identifier)/like")
    }
}

struct MyPostPhoto: Action {
    
    func perform(_ input: Photo) -> Promise<Void> {
        print("Post Photo")
        return Promise.resolve()
    }
}

