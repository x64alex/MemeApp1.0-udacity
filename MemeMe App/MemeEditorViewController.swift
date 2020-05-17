//
//  ViewController.swift
//  MemeMe App
//
//  Created by Mac on 28/04/2020.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var cancelImagePicker: UIBarButtonItem!
    @IBOutlet weak var shareImagePicker: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!

    //MARK: Initialize MemeBrain
    var meme = MemeBrain()
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the text
        meme.configTextFormat(topText, with: "TOP")
        meme.configTextFormat(bottomText, with: "BOTTOM")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Set up view as a delegate for the text fields
        topText.delegate = self
        bottomText.delegate = self
        
        // Enable camera only if the user has a camera
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Disable the share button until an image is created
        shareImagePicker.isEnabled = imagePickerView.image != nil
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topText && !meme.topTextEdited {
            textField.text = ""
            meme.topTextEdited = true
            shareImagePicker.isEnabled = true
        }
        
        if textField == bottomText && !meme.bottomTextEdited {
            textField.text = ""
            meme.bottomTextEdited = true
            shareImagePicker.isEnabled = true
        }
        
    }
    // Dismiss the keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Detects user touches on the screen in order to remove the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              var newImage: UIImage

              if let possibleImage = info[.editedImage] as? UIImage {
                  newImage = possibleImage
              } else if let possibleImage = info[.originalImage] as? UIImage {
                  newImage = possibleImage
              } else {
                  return
              }
                imagePickerView.image = newImage
              dismiss(animated: true)
          }
    //MARK: Meme creation
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolbarsControl(toptoolbar: true, bottomtoolbar: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolbarsControl(toptoolbar: false, bottomtoolbar: false)
        
        return memedImage
    }

    
    func pickAnImageFrom(from source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Navigation Bars ON/OFF
    
    // Set up when buttons are on or off and then dismiss them
    func buttonsControl(toptext: Bool, bottomtext: Bool){
        topText.isHidden = toptext
        bottomText.isHidden = bottomtext
    }
    
    // Set up when toolbars are on or off and then dismiss them
    func toolbarsControl(toptoolbar: Bool, bottomtoolbar: Bool){
        topToolBar.isHidden = toptoolbar
        bottomToolBar.isHidden = bottomtoolbar
    }
    
    
    func save(memedImage: UIImage?) {
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, image: imagePickerView.image!, memedImage: memedImage!)
        }
    //MARK: Actions
     @IBAction func shareButton(_ sender: Any) {
        // Memed image, with image and text, is generated
        let generatedImage = generateMemedImage()
        // Create the Activity View Controller
        let activityController = UIActivityViewController(activityItems: [generatedImage], applicationActivities: nil)
        // This sets up the save of the meme, which will be done when the Activity View Controller is completed
        activityController.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if (completed) {
                
                //Saving the Image
                self.save(memedImage: generatedImage)

                //To dismiss View Controller
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityController, animated: true, completion: nil)
      }
     
     @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImageFrom(from: .camera)
     }
     
     @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImageFrom(from: .photoLibrary)
    }

     // Cancel button to cancel the app.
     @IBAction func cancel(_ sender: Any) {
         imagePickerView.image = nil
         topText.text = "TOP"
         meme.topTextEdited = false
         bottomText.text = "BOTTOM"
        meme.bottomTextEdited = false
         shareImagePicker.isEnabled = false
         dismiss(animated: false, completion: nil)
     }
     

}


