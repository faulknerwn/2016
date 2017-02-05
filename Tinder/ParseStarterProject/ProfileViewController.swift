//
//  ProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Wendy Faulkner on 1/31/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBAction func updateProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker,animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBOutlet var genderSwitch: UISwitch!
    
    
    @IBOutlet var interestedInSwitch: UISwitch!
    
    
    @IBAction func update(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn
        
        let imageDate = UIImagePNGRepresentation(userImage.image!)
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageDate!)
        
        PFUser.current()?.saveInBackground(block: { (success,error) in
            if error != nil {
                
                var errorMessage = "Update Failed please try again"
                
                let error = error as NSError?
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                    
                }
                self.errorLabel.text = errorMessage
                
                
            } else {
                print("Updated")
                self.performSegue(withIdentifier: "showSwipingViewController", sender: self)
            }

        })
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let isFemale = PFUser.current()?["isFemale"]  as? Bool {
            genderSwitch.setOn(isFemale, animated: false)
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"]  as? Bool {
            genderSwitch.setOn(isInterestedInWomen, animated: false)
        }
        if let photo = PFUser.current()?["photo"]  as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data {
                    if let downloadedImage = UIImage(data: imageData) {
                        self.userImage.image = downloadedImage
                    }
                }
            })
        }

        
       /* let urlArray = ["http://d236bkdxj385sg.cloudfront.net/wp-content/uploads/2013/08/penny-proud.jpg","https://s-media-cache-ak0.pinimg.com/originals/34/ee/11/34ee11ec7c3e7c8ef3e15989e82d71f3.jpg","http://www.smosh.com/sites/default/files/ftpuploads/bloguploads/0713/weird-cartoon-character-gilrs-fb.jpg","http://static.makers.com/styles/homepage_carousel/s3/field/image/lisa-simpson-cartoon-576km071213.jpg?itok=WiYL2FoE"]
        let url2Array = ["http://esq.h-cdn.co/assets/cm/15/06/480x269/54d1ad6002078_-_esq-cartoons-dudley-do-right.jpg","http://esq.h-cdn.co/assets/cm/15/06/480x269/54d1ad60d8821_-_esq-cartoons-fred.jpg"]
        
        
        var counter = 0
        
        for url in urlArray {
            counter = counter + 1
            let url = URL(string: url)!
            do {
                
           let data = try Data(contentsOf: url)
                let imageFile = PFFile(name: "photo.png", data: data)
                let user = PFUser()
                user["photo"] = imageFile
                user.username = String(counter)
                user.password = "password"
                user["isInterestedInWomen"] = false
                user["isFemale"] = true
                let acl = PFACL()
                acl.getPublicWriteAccess = true
                acl.getPublicReadAccess    = true
                user.acl = acl
                user.signUpInBackground(block: { (success, error) in
                    if success {
                        print("user signed up")
                        
                    }
                })
                
            } catch {
                print("could not get data")
            }
        }

        counter = 0
        
        for url in url2Array {
            
            let url = URL(string: url)!
            counter = counter + 1
            do {
                
                let data = try Data(contentsOf: url)
                let imageFile = PFFile(name: "photo.png", data: data)
                let user = PFUser()
                user["photo"] = imageFile
                user.username = String(counter)
                user.password = "password"
                user["isInterestedInWomen"] = true
                user["isFemale"] = false
                let acl = PFACL()
                acl.getPublicWriteAccess = true
                acl.getPublicReadAccess    = true
                user.acl = acl
                user.signUpInBackground(block: { (success, error) in
                    if success {
                        print("user signed up")
                        
                    }
                })
                
            } catch {
                print("could not get data")
            }
        }
        */

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
