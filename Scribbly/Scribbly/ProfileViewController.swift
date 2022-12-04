//
//  ProfileViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var username_display: UILabel!
    @IBOutlet weak var photo_display: UIImageView!
    
    var storedName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photo_display.layer.cornerRadius = 60
        getProfileInfo()
    }
    
    func getProfileInfo(){
        if let StoredUserName = UserDefaults.standard.object(forKey: "StoredUserName") as? String{
            storedName = StoredUserName
            print("login:", storedName ?? "default")
            username_display.text = storedName
        }
    }
}
