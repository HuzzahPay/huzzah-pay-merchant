//
//  MerchantService.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/20/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import Firebase

struct MerchantService {
    
    static let shared = MerchantService()
    
    func fetchMerchant(uid: String, completion: @escaping(Merchant) -> Void) {
        DB_REF_MERCHANTS.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let merchant = Merchant(uid: uid, dictionary: dictionary)
            completion(merchant)
        })
    }
}
