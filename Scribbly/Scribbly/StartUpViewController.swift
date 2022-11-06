//
//  StartUpViewController.swift
//  Scribbly
//
//  Created by Kristen wang on 11/4/22.
//

import Foundation
import UIKit

class StartUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("launch Scribbly")
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
