//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Rowan Hisham on 4/18/20.
//  Copyright © 2020 Rowan Hisham. All rights reserved.
//

import UIKit

extension CreateMemeViewController: UITextFieldDelegate{
    
    // MARK: Reset Text When Field is Clicked
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isBottom = textField.tag == 1 ? true:false
        textField.text = ""
    }
    
    // MARK: Hides KeyBoard after Returning from Editing Text Field
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Subscribe to Show/Hide Keyboard
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Unubscribe from Show/Hide Keyboard
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: If Editing Bottom Text Field Push the View Up to it wont Hide the Text Field
    @objc func keyboardWillShow(_ notification:Notification) {
        if isBottom{
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Return View to Original Position After Keyboard is Hidden
    @objc func keyboardWillHide(_ notification:Notification) {
        if isBottom{
        view.frame.origin.y = 0
        }
    }
}
