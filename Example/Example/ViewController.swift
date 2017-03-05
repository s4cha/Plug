//
//  ViewController.swift
//  Example
//
//  Created by Sacha Durand Saint Omer on 04/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photo = Photo(identifier: 42)
        
        // Like Action
        photo.like().then {
            // photo has been liked
            print("photo liked : \(photo.isLiked)")
        }.onError { error in
            print("photo liked : \(photo.isLiked)")
            // photo couldn't be liked
        }
        
        // Post Action
        photo.post().then {
            // photo posted!
        }
    }
}

