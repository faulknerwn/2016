//
//  PictureViewController.swift
//  SnapChat
//
//  Created by Wendy Faulkner on 1/10/17.
//  Copyright © 2017 Leprechaun Skydiving. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class PictureViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var uuid = (NSUUID().uuidString)
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        nextButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
               let imagesFolder = FIRStorage.storage().reference().child("images")
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)! //0.1 is compression
        
        //UU generates random string
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("we tried to upload")
            
            if error != nil {
                print("We had an error:\(error)")
                
            } else {
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata!.downloadURL()!.absoluteString)
            }
        })

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //images is folder on firebase server
        
        let nextVC = segue.destination as! SelectUserViewController
        
        nextVC.imageURL = sender as! String
        nextVC.descript = textField.text!
        nextVC.uuid = uuid
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
   
    
        override func viewDidLoad() {
            super.viewDidLoad()
            imagePicker.delegate = self
            nextButton.isEnabled = false
            self.textField.delegate = self
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
