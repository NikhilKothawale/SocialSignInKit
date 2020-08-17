//
//  GoogleService.swift
//  SocialSignInKit
//
//  Created by Nikhil Kothawale on 15/08/20.
//  Copyright © 2020 Nikhil Kothawale. All rights reserved.
//

import Foundation

class GoogleService{
    
    var dict = [String: AnyObject]()
    static var singleInstance : GoogleService?
    
    static var sharedInstance : GoogleService{
        get {
            if singleInstance == nil{
                singleInstance = GoogleService()
            }
            return singleInstance!
        }
    }
    
    private init() {
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            self.dict = dict
        }
    }
    
    var clientID : String{
        get {
            return dict["CLIENT_ID"] as! String
        }
    }
}
