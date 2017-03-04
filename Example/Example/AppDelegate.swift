//
//  AppDelegate.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Actions
import then

typealias TLikePhoto = AnyAction<Photo, Promise<Void>>
typealias TPostPhoto =  AnyAction<Photo, Promise<Void>>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tLikePhoto =  AnyAction(MyWebApiLikePhoto())
        print(tLikePhoto)
        print(tLikePhoto.self)
        if let tPostPhoto = tLikePhoto as? LikePhoto {
            print(tPostPhoto)
            print("SAME TYPES")
        }
        
        // Here we provide our delivery mechanism, here a web Api.
        // The entire app has no idea of the web Api.
        // The dependency is `injected` in the App delegate.
        Actions.plug(LikePhoto.self, to: MyWebApiLikePhoto())
        Actions.plug(PostPhoto.self, to: MyWebApiPostPhoto())

        return true
    }
}

