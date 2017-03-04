//
//  MyWebApiLikePhoto.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import then
import ws

struct MyWebApiLikePhoto: LikePhoto {
    
    let ws = WS("https://jsonplaceholder.typicode.com")
    
    func perform(_ input: Photo) -> Promise<Void> {
        return ws.post("/photos/\(input.identifier)/like")
    }
}
