//
//  SelectPhotoViewController.swift
//  Scribbly
//
//  Created by Kristen wang on 12/3/22.
//

import UIKit

class SelectPhotoViewController: UIViewController{
    
    @IBOutlet weak var photo1: UIButton!
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo3: UIButton!
    @IBOutlet weak var photo4: UIButton!
    @IBOutlet weak var background_view: UIView!
    @IBOutlet weak var button_title: UIButton!
    
    var photoName: String = "default_profile"
    var username: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print("username from SignUpViewController: \(username)")
        photo1.layer.cornerRadius = 20
        photo1.layer.masksToBounds = true
        photo2.layer.cornerRadius = 20
        photo2.layer.masksToBounds = true
        photo3.layer.cornerRadius = 20
        photo3.layer.masksToBounds = true
        photo4.layer.cornerRadius = 20
        photo4.layer.masksToBounds = true
        background_view.layer.borderWidth = 2
        background_view.layer.cornerRadius = 30
        background_view.layer.borderColor = MyColor.green1.cgColor
        button_title.titleLabel?.font = Font.H1
    }
    
    @IBAction func skip(_ sender: Any) {
        //set user photo to default
        //jump to login page
        print("skip choosing photo")
        photoName = "default_profile"
        
        if var tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]]{
            tempData.append([username, password, photoName])
            UserDefaults.standard.set(tempData, forKey: "UserInfo")
            print(tempData)
        }
        
        let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func photo1_select(_ sender: Any) {
        photoName = "profile1"
        photo1.layer.borderWidth = 3.5
        photo1.layer.borderColor = MyColor.green2.cgColor
        photo2.layer.borderColor = UIColor.clear.cgColor
        photo3.layer.borderColor = UIColor.clear.cgColor
        photo4.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func photo2_select(_ sender: Any) {
        photoName = "profile2"
        photo2.layer.borderWidth = 3.5
        photo2.layer.borderColor = MyColor.green2.cgColor
        photo1.layer.borderColor = UIColor.clear.cgColor
        photo3.layer.borderColor = UIColor.clear.cgColor
        photo4.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func photo3_select(_ sender: Any) {
        photoName = "profile3"
        photo3.layer.borderWidth = 3.5
        photo3.layer.borderColor = MyColor.green2.cgColor
        photo2.layer.borderColor = UIColor.clear.cgColor
        photo1.layer.borderColor = UIColor.clear.cgColor
        photo4.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func photo4_select(_ sender: Any) {
        photoName = "profile4"
        photo4.layer.borderWidth = 3.5
        photo4.layer.borderColor = MyColor.green2.cgColor
        photo2.layer.borderColor = UIColor.clear.cgColor
        photo1.layer.borderColor = UIColor.clear.cgColor
        photo3.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func allset_pressed(_ sender: Any) {
        //save current photoName to UserInfo in UserDefaults
        if var tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]]{
            tempData.append([username, password, photoName])
            UserDefaults.standard.set(tempData, forKey: "UserInfo")
            print(tempData)
        }
        
        //jump to login page & set login photo
        let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
        loginVC.login_photo_name = photoName
    }
    
}
