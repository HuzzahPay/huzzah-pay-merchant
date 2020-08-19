//
//  Utilities.swift
//  HuzzahPay Merchant
//
//  Created by Apurva Deshmukh on 8/19/20.
//  Copyright © 2020 HuzzahPay. All rights reserved.
//

import UIKit

class Utilities {
    
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.backgroundColor = .huzzahPurple
        view.layer.cornerRadius = 10
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        iv.centerY(inView: view)
        iv.anchor(left: view.leftAnchor, paddingLeft: 8)
        iv.setDimensions(width: 30, height: 26)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                         paddingLeft: 8, paddingBottom: 20)
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart,
                                                  attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                  NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
