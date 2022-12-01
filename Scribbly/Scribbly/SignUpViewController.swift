//
//  SignUpViewController.swift
//  Scribbly
//
//  Created by Kristen wang on 11/4/22.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var confirmPassword_field: UITextField!
    @IBOutlet weak var alert: UILabel!
    
    var this_user: User!
    var input_username: String!
    var input_password: String!
    var input_confirmPassword: String!
    var signup_success: Bool!
    var find_repeat: Bool!
    var match_password: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        input_username = username_field.text!
        input_password = password_field.text!
        input_confirmPassword = confirmPassword_field.text!
        alert.text = " "
        signup_success = false
        find_repeat = false
        match_password = true
//        UserDefaults.standard.set([], forKey: "UserInfo")
        

    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        
        input_username = username_field.text!
        input_password = password_field.text!
        input_confirmPassword = confirmPassword_field.text!
        
        if var tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]] {
            
            print("data get")
            print(tempData)
            print("input username: \(input_username!)")
    
            //[a,b] b
            
            //iterate all entries
            for item in tempData{
                
                if item[0].contains(input_username){
                    print("input username repeat: \(input_username!)")
                    alert.text = "* occupied username"
                    find_repeat = true
                    print("here3")
                    break
                }else{
                    find_repeat = false
                    print("here4")
                }
            }
            
            if input_password != input_confirmPassword{
                match_password = false
                alert.text = "* unmatched password entries"
            }else{
                match_password = true
            }
            
            if !find_repeat && match_password{
                print("here2")
                tempData.append([input_username, input_password])
                alert.text = "Sign Up Successful"
                signup_success = true
            }
            
            UserDefaults.standard.set(tempData, forKey: "UserInfo")
        }
        else{
            print(" no data get")
            var tempData:[[String]] = []
            tempData.append([input_username, input_password])
            UserDefaults.standard.set(tempData, forKey: "UserInfo")
        }
        print("here")
        print(UserDefaults.standard.object(forKey: "UserInfo") as? [[String]])
        
        if signup_success{
            let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(loginVC, animated: true)
        }
        
    }
    
}
