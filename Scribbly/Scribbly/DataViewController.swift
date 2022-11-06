//
//  DataViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/4/22.
//

import UIKit



class DataViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    var questionText:String = "default question"
    var answerText:String = "default answer"
    
    var index:Int = 0
    
    var rear:Bool = false
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        rear = !rear
        updateContents()
            
    }
    
    func updateContents(){
        if rear{
            frontLabel.isHidden = true
            backLabel.isHidden = false
            self.view.backgroundColor = .yellow
        }else{
            frontLabel.isHidden = false
            backLabel.isHidden = true
            self.view.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.text = questionText
        backLabel.text = answerText
        
        updateContents()
        
        print("DataView with index \(index) is loaded.")

        // Do any additional setup after loading the view.
    }
    

}
