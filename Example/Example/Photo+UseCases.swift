//
//  Photo+UseCases.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Plug
import Then

// This is an optional sugar 
// We develop software for humans
// calling photo.like is more intuitive that calling `action(_likePhoto, photo)` :)

extension Photo {
    
    func like() -> Promise<Void> {
        return action(LikePhoto.self, self)
    }

    func post() -> Promise<Void> {
        return action(PostPhoto.self, self)
    }
}


// Another cool thing is that here you could implement Optimistic likes
//extension Photo {
//    func like() -> Promise<Void> {
//        isLiked = true
//        let p = action(_likePhoto, self)
//        p.onError { e in
//            self.isLiked = false
//        }
//        return p
//    }
//}
