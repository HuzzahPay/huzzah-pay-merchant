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
        iv.image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    private lazy var shopContainerView: UIView = {
        var view = UIView()
        if let image = UIImage(systemName: "cart.fill")?.withTintColor(.huzzahDarkPink, renderingMode: .alwaysOriginal) {
            view = Utilities().inputContainerView(withImage: image, textField: storeTextField)
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
    
    private let storeTextField: UITextField = {
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
    
    private lazy var authStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shopContainerView, emailContainerView,
                                                   passwordContainerView, confirmPasswordContainerView, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoImageView)
        view.addSubview(authStack)
        view.addSubview(dontHaveAccountButton)

        configureNavigationBar()
        configureTextFieldDelegates()
        configureUI()
        configureElements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.setDimensions(width: view.frame.height/4, height: view.frame.height/4)
         
        authStack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 20, paddingLeft: 150, paddingRight: 150)
        
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Selectors
    
    @objc func handleRegister() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let store = storeTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        guard password == confirmPassword else { return }
        
        let credentials = AuthCredentials(email: email, password: password, storeName: store)
        
        AuthService.shared.registerMerchant(credentials: credentials, completion: { [weak self] error, ref in
            if let error = error {
                print("DEBUG: Error logging in with error: \(error.localizedDescription)")
                return
            }
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            guard let controller = window.rootViewController as? PaymentController else { return }
            controller.authenticateUserAndConfigureUI()
            self?.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        storeTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        confirmPasswordTextField.endEditing(true)
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        storeTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (view.frame.origin.y == 0) {
                self.view.frame.origin.y -= (keyboardSize.height/2+10)
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
    }
    
    private func configureElements() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == storeTextField) {
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

