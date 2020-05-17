//
//  Meme.swift
//  myMeMe
//
//  Created by Vinicius Granja on 5/1/18.
//  Copyright © 2018 Vinicius Granja. All rights reserved.
//

import UIKit

//the Meme struct stores data needed to save a Meme
struct Meme {
    var topText : String
    var bottomText : String
    var image : UIImage
    var memedImage : UIImage
}
class MemeBrain: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var topTextEdited = false
    var bottomTextEdited = false
    
    let memeTextAttributes:[NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.backgroundColor: UIColor.clear,
        NSAttributedString.Key.strokeWidth: -4.0
    ]
    
    func configTextFormat(_ textField: UITextField, with defaultText: String) {
           textField.defaultTextAttributes = memeTextAttributes
           textField.textAlignment = NSTextAlignment.center
           textField.text = defaultText
           textField.isHidden = false
       }
    
}
