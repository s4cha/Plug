//
//  Actions.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Actions
import then

var _likePhoto: AnyAction<Photo, Promise<Void>>!
var _postPhoto: AnyAction<Photo, Promise<Void>>!
// find a way to stringly type Actions?
