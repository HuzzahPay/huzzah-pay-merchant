//
//  PaymentController.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/18/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import UIKit
import Firebase

class PaymentController: UIViewController {
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .huzzahDark
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            print("DEBUG: User exists")
        }
    }
}
