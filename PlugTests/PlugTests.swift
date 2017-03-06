//
//  PlugTests.swift
//  PlugTests
//
//  Created by Sacha Durand Saint Omer on 06/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import XCTest
import Actions

class PlugTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        AUseCase.self <~ MyUseCaseImplementation()
        AVoidInputUseCase.self <~ MyVoidInputUseCaseImplementation()
    }
    
    func testUndefinedActionYieldsNilIsCalled() {
        let undefinedAction = UndefinedUseCase()
        let result = undefinedAction.perform("")
        XCTAssertNil(result)
    }
    
    func testConcreteImplementationIsCalled() {
        let result = action(AUseCase.self, "Great")
        XCTAssertTrue(result)
        
        let result2 = action(AUseCase.self, "Nope")
        XCTAssertFalse(result2)
    }
    
    func testCanCallVoidInputAction() {
        let result2 = action(AVoidInputUseCase.self)
        XCTAssertEqual(result2, "Super")
    }
}
