//
//  LoginViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    var input_username: String!
    var input_password: String!
    var login_success: Bool!
    var username_found: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        login_success = false
        input_username = username_field.text!
        input_password = password_field.text!
        username_found = false
        alert.text = " "
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
            }
            else{
                for pairedItem in tempData{
                    if input_username == pairedItem[0]{
                        if input_password == pairedItem[1]{
                            print("username & password match")
                            login_success = true
                            //turn to the next view controller
                            //remember this user
                            
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
        }
    }
    
}
