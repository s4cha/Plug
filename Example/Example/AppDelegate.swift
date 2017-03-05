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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Here we provide our delivery mechanism, here a web Api.
        // The entire app has no idea of the web Api.
        // The dependency is `injected` in the App delegate.
        
//        Actions.plug(LikePhoto.self, to: MyLikePhoto())
//        Actions.plug(PostPhoto.self, to: MyPostPhoto())
        
        LikePhoto.self <~ MyLikePhoto()
        PostPhoto.self <~ MyPostPhoto()
        
        return true
    }
}
