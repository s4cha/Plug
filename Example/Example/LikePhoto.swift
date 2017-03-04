//
//  LikePhoto.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Actions
import then

//typealias LikePhoto = AnyAction<Photo, Promise<Void>>

class LikePhoto: AnAction<Photo, Promise<Void>> {}
class PostPhoto: AnAction<Photo, Promise<Void>> {}





protocol LikePhotoType {
    var action: AnAction<Photo, Promise<Void>>
}

