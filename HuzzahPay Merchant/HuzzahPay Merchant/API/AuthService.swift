//
//  AuthManager.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/20/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let storeName: String
}

struct AuthService {
    
    static let shared = AuthService()
    
    // MARK: - Authentication
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerMerchant(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let storeName = credentials.storeName
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            let values = ["email": email,
                          "store-name": storeName]
            
            DB_REF_MERCHANTS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
    
    func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            completion(false)
            print("DEBUG: \(error.localizedDescription)")
            return
        }
    }
    
}
