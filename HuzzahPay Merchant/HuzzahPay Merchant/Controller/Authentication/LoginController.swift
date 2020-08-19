//
//  LoginController.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/18/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let huzzahPayLabel: UILabel = {
        let label = UILabel()
        label.text = "Huzzah Pay"
        label.font = UIFont(name: "Avenir", size: 100.0)
        label.textColor = .huzzahDarkPink
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        view.backgroundColor = .huzzahDark
        view.addSubview(huzzahPayLabel)
        huzzahPayLabel.centerX(inView: view)
        huzzahPayLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
    }
    
    
}
