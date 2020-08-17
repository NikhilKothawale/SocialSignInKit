//
//  FacebookUser.swift
//  SocialSignInKit
//
//  Created by Indexnine on 17/08/20.
//  Copyright © 2020 Nikhil Kothawale. All rights reserved.
//

import Foundation

public class FacebookUser {
    
    var _userId : String = ""
    var _name : String?
    var _email : String?
    var _authorizationCode: String?
    
    open var userId : String {
        return _userId
    }
    
    open var name : String? {
        return _name
    }
    
    open var email : String? {
        return _email
    }
    
    open var authorizationCode : String? {
           return _authorizationCode
       }
    
    init(userId: String, name: String?, email: String?, authorizationCode: String?) {
        self._userId = userId
        self._name = name
        self._email  = email
        self._authorizationCode = authorizationCode
        
    }
    
}
