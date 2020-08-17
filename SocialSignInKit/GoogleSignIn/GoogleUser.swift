//
//  GoogleUser.swift
//  SocialSignInKit
//
//  Created by Nikhil Kothawale on 15/08/20.
//  Copyright © 2020 Nikhil Kothawale. All rights reserved.
//

import Foundation

public class GoogleUser {
    
    var _userId : String = ""
    var _idToken : String?
    var _fullName : String?
    var _givenName : String?
    var _familyName : String?
    var _email : String?
    
    open var userId : String {
        return _userId
    }
    
    open var idToken : String? {
        return _idToken
    }
    
    open var fullName : String? {
        return _fullName
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
    
    init(userId: String, idToken: String?,  fullName: String?, givenName: String?, familyName: String?, email: String?) {
        self._userId = userId
        self._idToken = idToken
        self._fullName = fullName
        self._givenName = givenName
        self._familyName = familyName
        self._email  = email
        
    }
    
}
