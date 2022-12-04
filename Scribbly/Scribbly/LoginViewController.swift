//
//  LoginViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit

var curUser:String = ""

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var profile_photo: UIImageView!
    @IBOutlet weak var login_button: UIButton!
    
    var input_username: String!
    var input_password: String!
    var login_success: Bool!
    var username_found: Bool!
    var login_photo_name: String = "default_profile"
    
    @IBOutlet weak var username_title: UILabel!
    @IBOutlet weak var password_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(login_photo_name)
        changePhoto()
        
        background_view.layer.cornerRadius = 30
        profile_photo.layer.cornerRadius = 60
        //set shadow
        profile_photo.layer.shadowColor = UIColor.black.cgColor
        profile_photo.layer.shadowOffset = CGSize(width: 3, height: 3)
        profile_photo.layer.shadowRadius = 8
        profile_photo.layer.shadowOpacity = 0.7
        
        username_title.font = Font.H2
        password_title.font = Font.H2
        login_button.titleLabel?.font = Font.H1
        login_button.titleLabel?.font = Font.H1
        login_button.layer.shadowRadius = 5
        login_button.layer.shadowColor = UIColor.black.cgColor
        login_button.layer.shadowOpacity = 0.3
        login_button.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        login_success = false
        input_username = username_field.text!
        input_password = password_field.text!
        username_found = false
        alert.text = " "
    }
    
    func changePhoto(){
        profile_photo.image = UIImage(named: login_photo_name)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
//        let current_item: [String] = []
        input_username = username_field.text!
        input_password = password_field.text!
        
        if let tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]]{
            
            for item in tempData{
                if item[0].contains(input_username){
                    print("found username")
                    username_found = true
                }
            }
            
            if !username_found{
                alert.text = "* username not found"
                return
            }
            else{
                for pairedItem in tempData{
                    if input_username == pairedItem[0]{
                        if input_password == pairedItem[1]{
                            print("username & password match")
                            login_success = true
                            //turn to the next view controller
                            
                            //remember this user
                            curUser = input_username
                            UserDefaults.standard.set(input_username, forKey: "StoredUserName")
   
                        }else{
                            login_success = false
                            alert.text = "* incorrect password"
                        }
                    }else{
                        continue
                    }
                }
            }
        }
            

        if login_success == true{
            
            let libVC = storyboard!.instantiateViewController(withIdentifier: "LibraryView") as! LibraryViewController
            navigationController?.pushViewController(libVC, animated: true)
            username_found = false

        }
    }
    
}
