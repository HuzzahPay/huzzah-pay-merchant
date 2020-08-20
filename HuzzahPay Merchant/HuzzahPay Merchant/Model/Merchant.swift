//
//  Merchant.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/20/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import Firebase

struct Merchant {
    let storeName: String
    let email: String
    let uid: String
    
    var isCurrentMerchant: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.storeName = dictionary["store-name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
