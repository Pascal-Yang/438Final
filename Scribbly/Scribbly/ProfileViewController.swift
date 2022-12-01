//
//  ProfileViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var username_display: UILabel!
    
    var storedName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getProfileInfo()
    }
    
    func getProfileInfo(){
        if let StoredUserName = UserDefaults.standard.object(forKey: "StoredUserName") as? String{
            storedName = StoredUserName
            print(storedName ?? "default")
            username_display.text = storedName
        }
    }
}
