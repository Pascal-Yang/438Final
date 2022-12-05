//
//  EditPhotoViewController.swift
//  Scribbly
//
//  Created by Kristen wang on 12/4/22.
//

import UIKit

class EditPhotoViewController: UIViewController{
    
    @IBOutlet weak var photo1: UIButton!
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo3: UIButton!
    @IBOutlet weak var photo4: UIButton!
    
    @IBOutlet weak var background_view: UIView!
    
    var photoName: String = "default_profile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func photo1_select(_ sender: Any) {
        photoName = "profile1"
    }
    
    @IBAction func photo2_select(_ sender: Any) {
        photoName = "profile2"
    }
    
    @IBAction func photo3_select(_ sender: Any) {
        photoName = "profile3"
    }
    
    @IBAction func photo4_select(_ sender: Any) {
        photoName = "profile4"
    }
    
    @IBAction func change_pressed(_ sender: Any) {
        
        if var tempData = UserDefaults.standard.object(forKey: "UserInfo") as? [[String]]{
            
        }
        
        //jump to profile page
        let profileVC = storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}
