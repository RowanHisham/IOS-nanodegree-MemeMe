//
//  ViewController.swift
//  MemeMe
//
//  Created by Rowan Hisham on 4/18/20.
//  Copyright © 2020 Rowan Hisham. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var memeImage: UIImage!
    
    var textFieldProperties: TextFieldProperties!
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var MemeImage: UIImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textFieldProperties = TextFieldProperties(view: view)
        textFieldProperties.subscribeToKeyboardNotifications()
        topTextField.delegate = textFieldProperties
        bottomTextField.delegate = textFieldProperties

        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textFieldProperties.unsubscribeFromKeyboardNotifications()
    }

    func configureUI(){
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        topTextField.defaultTextAttributes = textFieldProperties.textAttributes
        bottomTextField.defaultTextAttributes = textFieldProperties.textAttributes
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.textAlignment = NSTextAlignment.center
    }
    
    // MARK: Display Image Picker Controller [Library]
    @IBAction func pickImageLibrary(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: Display Image Picker Controller [Camera]
    @IBAction func pickImageCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: Save Image Picked and dismiss the Picker View
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: Generate Image From View
    func generateMemedImage() -> UIImage {
        topBar.isHidden = true
        bottomBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topBar.isHidden = false
        bottomBar.isHidden = false
        
        return memedImage
    }
    
    // MARK: Generate Meme and Display ActivityView
    @IBAction func ShareButtonClicked(_ sender: Any) {
        memeImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)

        controller.completionWithItemsHandler = { (activity, success, items, error) in
            if success{self.save()}
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    // MARK: Reset View
    @IBAction func CancelButtonClicked(_ sender: Any) {
        imagePickerView.image = nil
        topTextField.text = "Top"
        bottomTextField.text = "Bottom"
        shareButton.isEnabled = false
    }
    
    // MARK: WILL BE USED LATER
    func save(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, MemeImage: memeImage)
    }
}

