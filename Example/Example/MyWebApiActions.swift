//
//  MyWebApiActions.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Then
import ws
import Plug

var network: WS = {
    let ws = WS("https://jsonplaceholder.typicode.com")
    ws.logLevels = .debug
    return ws
}()

class MyLikePhoto: LikePhoto {
    
    override func perform(_ input: Photo) -> Promise<Void> {
        print("Like Photo")
       return network.post("/photos/\(input.identifier)/like")
    }
}

class MyPostPhoto: PostPhoto {
    
    override func perform(_ input: Photo) -> Promise<Void> {
        print("Post Photo")
        return Promise.resolve()
    }
}

