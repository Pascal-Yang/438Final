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
    var storedPhoto: String = "profile2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photo_display.layer.cornerRadius = 60
        getProfileInfo()
    }
    
    func getProfileInfo(){
        username_display.text = curUser
        if let tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]]{
            
            for item in tempData{
                if item[0] == curUser{
                    storedPhoto = item[2]
                    print(curUser)
                    print(item)
                }
            }
        }
        
        print(UserDefaults.standard.object(forKey: "UserInfo") as? [[String]])
        print("profile photo name: \(storedPhoto)")
        photo_display.image = UIImage(named: storedPhoto)
    }
}
