//
//  StartUpViewController.swift
//  Scribbly
//
//  Created by Kristen wang on 11/4/22.
//

import Foundation
import UIKit

class StartUpViewController: UIViewController {
    
    @IBOutlet weak var signup_button: UIButton!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var labeltext: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("launch Scribbly")
        signup_button.titleLabel?.font = Font.H1
        login_button.titleLabel?.font = Font.H1
        labeltext.font = Font.H2
        print(UserDefaults.standard.object(forKey: "UserInfo") as? [[String]] ?? [[]])
        
//        UserDefaults.standard.set([], forKey: "UserInfo")
    }
    
    @IBAction func login_pressed(_ sender: Any) {
        let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signup_pressed(_ sender: Any) {
        let signUpVC = storyboard!.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}
