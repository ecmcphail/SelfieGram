//
//  ProfileViewController.swift
//  SelfieGram
//
//  Created by Emma McPhail on 2017-11-13.
//  Copyright © 2017 Emma McPhail. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBAction func cameraButtonPressed(_ sender: Any) {
        // 1: Create an ImagePickerController
            let pickerController = UIImagePickerController()
        
        // 2: Self in this line refers to this View Controller
        //    Setting the Delegate Property means you want to receive a message
        //    from pickerController when a specific event is triggered.
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // 3. We check if we are running on a Simulator
            //    If so, we pick a photo from the simulator’s Photo Library
            // We need to do this because the simulator does not have a camera
            pickerController.sourceType = .photoLibrary
        } else {
            // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
            //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        // Preset the pickerController on screen
        self.present(pickerController, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = PFUser.current(){
            usernameLabel.text = user.username
            
            if let imageFile = user["avatarImage"] as? PFFile {
                
                imageFile.getDataInBackground(block: { (data, error) -> Void in
                    if let imageData = data {
                        self.profileImageView.image = UIImage(data: imageData)
                    }
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "Emma"
        // Do any additional setup after loading the view.
        navigationItem.titleView = UIImageView(image: UIImage(named: "Selfigram-logo"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that may be useful to us.
        //    We are getting the image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // setting the compression quality to 90%
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
                // avatarImage is a new column in our User table
                user["avatarImage"] = imageFile
                user.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        // set our profileImageView to be the image we have picked
                        let image = UIImage(data: imageData)
                        self.profileImageView.image = image
                    }
                })
                
            }
            
            
        }
        
        //3. We remember to dismiss the Image Picker from our screen.
        dismiss(animated: true, completion: nil)
        
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


