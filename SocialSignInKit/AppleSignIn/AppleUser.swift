//
//  AppleUser.swift
//  SocialSignInKit
//
//  Created by Indexnine on 15/08/20.
//  Copyright © 2020 Nikhil Kothawale. All rights reserved.
//

import Foundation

public class AppleUser {
    
    var _userId : String = ""
    var _idToken : String?
    var _authorizationCode: String?
    var _givenName : String?
    var _familyName : String?
    var _email : String?
    
    open var userId : String {
        return _userId
    }
    
    open var idToken : String? {
        return _idToken
    }
    
    open var authorizationCode : String? {
        return _authorizationCode
    }
    
    open var givenName : String? {
        return _givenName
    }
    
    open var familyName : String? {
        return _familyName
    }
    
    open var email : String? {
        return _email
    }
    
    init(userId: String, idToken: String?, authorizationCode: String?, givenName: String?, familyName: String?, email: String?) {
        self._userId = userId
        self._idToken = idToken
        self._givenName = givenName
        self._familyName = familyName
        self._email  = familyName
        self._authorizationCode = authorizationCode
        
    }
    
}
