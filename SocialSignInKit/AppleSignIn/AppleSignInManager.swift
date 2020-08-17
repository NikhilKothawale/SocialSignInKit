//
//  AppleSignInManager.swift
//  SocialSignInKit
//
//  Created by Nikhil Kothawale on 15/08/20.
//  Copyright © 2020 Nikhil Kothawale. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

public protocol AppleSignInManagerDelegate: NSObjectProtocol {
    func appleSignIn(didCompleteWithUser appleUser: AppleUser)
    func appleSignIn(didCompleteWithError error: Error)
}

@available(iOS 13.0, *)
public class AppleSignInManager: NSObject {
    
    private var controller: ASAuthorizationController?
    
    weak open var delegate: AppleSignInManagerDelegate?
    public var presentingController: UIViewController? {
        didSet{
            self.controller?.delegate = self
            self.controller?.presentationContextProvider = self
        }
    }
    
    private override init() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        self.controller = ASAuthorizationController(authorizationRequests: [request])
    }
    
    private static var singleInstance : AppleSignInManager?
    
    private var appleUser : AppleUser!
    
    public static var sharedInstance: AppleSignInManager {
        get{
            if singleInstance == nil {
                singleInstance = AppleSignInManager()
            }
            
            return singleInstance!
        }
    }
    
    public func logIn(){
        self.controller?.performRequests()
    }
}

@available(iOS 13.0, *)
extension AppleSignInManager: ASAuthorizationControllerDelegate{
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential :
            
            let userId = credentials.user
            let idToken = String(data: credentials.identityToken!, encoding: .utf8)
            let authorizationCode = String(data: credentials.authorizationCode!, encoding: .utf8)
            let givenName = credentials.fullName?.givenName
            let familyName = credentials.fullName?.familyName
            let email = credentials.email
            
            appleUser = AppleUser(userId: userId, idToken: idToken, authorizationCode: authorizationCode!, givenName: givenName, familyName: familyName, email: email)
            self.delegate?.appleSignIn(didCompleteWithUser: appleUser)
            
        default:
            break
        }
    }
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.appleSignIn(didCompleteWithError: error)
    }
}

@available(iOS 13.0, *)
extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding{
    
    @available(iOS 13.0, *)
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (self.presentingController?.view.window)!
    }
    
}
