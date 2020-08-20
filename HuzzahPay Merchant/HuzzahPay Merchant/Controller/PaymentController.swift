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
    
    // MARK: - Properties
    
    var merchant: Merchant? {
        didSet {
            configureElements()
        }
    }
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .huzzahLightPurple
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    private let storeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = .huzzahDarkPink
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoutButton)
        view.addSubview(storeLabel)
        authenticateUserAndConfigureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                            paddingTop: 20, paddingLeft: 150, paddingRight: 150)
        storeLabel.anchor(top: logoutButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                          paddingTop: 20, paddingLeft: 150, paddingRight: 150)
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
            configureUI()
            fetchMerchant()
        }
    }
    
    func fetchMerchant() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        MerchantService.shared.fetchMerchant(uid: uid, completion: { merchant in
            print("DEBUG: merchant is ")
            self.merchant = merchant
        })
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        AuthService.shared.logOut { (success) in
            if (success) {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            } else {
                print("DEBUG: error logging out")
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .huzzahDark
    }
    
    func configureElements() {
        guard let merchant = merchant else { return }
        
        storeLabel.text = merchant.storeName
    }
}
