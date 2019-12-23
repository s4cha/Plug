//
//  UseCasesImplementations.swift
//  Actions
//
//  Created by Sacha Durand Saint Omer on 06/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

class MyUseCaseImplementation: AUseCase {
    
    override func perform(_ input: String) -> Bool {
        return input == "Great"
    }
}


class MyVoidInputUseCaseImplementation: AVoidInputUseCase {
    
    override func perform(_ input: Void) -> String {
        return "Super"
    }
}
