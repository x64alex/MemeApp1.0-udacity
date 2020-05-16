//
//  ViewController.swift
//  MemeMe App
//
//  Created by Mac on 28/04/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseBuuton: UIButton!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    var imagePicker = UIImagePickerController()
   
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topText && !topTextEdited {
            textField.text = ""
            topTextEdited = true
            shareImagePicker.isEnabled = true
        }
        
        if textField == bottomText && !bottomTextEdited {
            textField.text = ""
            bottomTextEdited = true
            shareImagePicker.isEnabled = true
        }
        
    }

    override func viewDidLoad() {
        // Enable camera only if the user has a camera
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    //Pick image from Album
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    //Set up the cancel button
    @IBAction func cancelApp(sender: Any) {
        imageView.image = nil
        topText.text = "TOP"

        bottomText.text = "BOTTOM"
       
        dismiss(animated: false, completion: nil)
    }
    //Pick an image function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           var newImage: UIImage

           if let possibleImage = info[.editedImage] as? UIImage {
               newImage = possibleImage
           } else if let possibleImage = info[.originalImage] as? UIImage {
               newImage = possibleImage
           } else {
               return
           }

           // do something interesting here!
            imageView.image = newImage
           dismiss(animated: true)
       }
}

