//
//  MyWebApiLikePhoto.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import then
import ws
import Actions

class MyWebApiLikePhoto: LikePhoto {

    let ws = WS("https://jsonplaceholder.typicode.com")
    
    override func perform(_ input: Photo) -> Promise<Void> {
        print("Liking Photo")
        return ws.post("/photos/\(input.identifier)/like")
    }
}

class MyWebApiPostPhoto: PostPhoto {
    
    let ws = WS("https://jsonplaceholder.typicode.com")
    
    override func perform(_ input: Photo) -> Promise<Void> {
        print("Posting Photo")
        return Promise.resolve()
    }
}
