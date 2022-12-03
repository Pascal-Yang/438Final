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
    @IBOutlet weak var scribble_view: UIImageView!
    
    var questionText:String = "default question"
    var answerText:String = "default answer"
    var scribble_img = UIImage(systemName: "house")!
    
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
            scribble_view.isHidden = false
            self.view.backgroundColor = MyColor.blue1
            
            if scribble_img.pngData() == UIImage(systemName: "house")?.pngData(){
                scribble_view.isHidden = true
            }
            
        }else{
            frontLabel.isHidden = false
            backLabel.isHidden = true
            scribble_view.isHidden = true
            self.view.backgroundColor = MyColor.green3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontLabel.text = questionText
        backLabel.text = answerText
        scribble_view.image = self.scribble_img
        
        updateContents()
        
        print("DataView with index \(index) is loaded.")

        // Do any additional setup after loading the view.
    }
    

}
