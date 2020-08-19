//
//  RegistrationController.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/18/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .huzzahDarkPink
        return iv
    }()
    
    private lazy var shopContainerView: UIView = {
        var view = UIView()
        if let image = UIImage(systemName: "cart.fill")?.withTintColor(.huzzahDarkPink, renderingMode: .alwaysOriginal) {
            view = Utilities().inputContainerView(withImage: image, textField: shopTextField)
        }
        return view
    }()
    
    private lazy var emailContainerView: UIView = {
        var view = UIView()
        if let image = UIImage(systemName: "envelope.fill")?.withTintColor(.huzzahDarkPink, renderingMode: .alwaysOriginal) {
            view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        }
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        var view = UIView()
        if let image = UIImage(systemName: "lock.fill")?.withTintColor(.huzzahDarkPink, renderingMode: .alwaysOriginal) {
            view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        }
        return view
    }()
    
    private lazy var confirmPasswordContainerView: UIView = {
        var view = UIView()
        if let image = UIImage(systemName: "lock.fill")?.withTintColor(.huzzahDarkPink, renderingMode: .alwaysOriginal) {
            view = Utilities().inputContainerView(withImage: image, textField: confirmPasswordTextField)
        }
        return view
    }()
    
    private let shopTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Store Name")
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.returnKeyType = .next
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.returnKeyType = .next
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.returnKeyType = .continue
        return tf
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Confirm Password")
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.returnKeyType = .continue
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .huzzahLightPurple
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTextFieldDelegates()
        configureUI()
        configureElements()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Selectors
    
    @objc func handleRegister() {
        print("DEBUG: did tap register")
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        shopTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        confirmPasswordTextField.endEditing(true)
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        shopTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (view.frame.origin.y == 0) {
                self.view.frame.origin.y -= (keyboardSize.height/2)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        view.backgroundColor = .huzzahDark
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.setDimensions(width: view.frame.width/2, height: view.frame.height/5)
        
        let stack = UIStackView(arrangedSubviews: [shopContainerView, emailContainerView,
                                                   passwordContainerView, confirmPasswordContainerView, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 20, paddingLeft: 150, paddingRight: 150)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureElements() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == shopTextField) {
            emailTextField.becomeFirstResponder()
        } else if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else if (textField == passwordTextField) {
            confirmPasswordTextField.becomeFirstResponder()
        } else if (textField == confirmPasswordTextField) {
            handleRegister()
        }
        return true
    }
}

