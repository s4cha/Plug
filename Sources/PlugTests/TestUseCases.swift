//
//  TestUseCases.swift
//  Actions
//
//  Created by Sacha Durand Saint Omer on 06/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Plug

class UndefinedUseCase: Action<String,String> { }
class AUseCase: Action<String,Bool> { }
class AVoidInputUseCase: Action<Void,String> { }
