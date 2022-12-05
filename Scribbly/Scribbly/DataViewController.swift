//
//  DataViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/4/22.
//

import UIKit



class DataViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var scribble_view: UIImageView!
    @IBOutlet weak var backLabel: UITextView!
    
    var questionText:String = "default question"
    var answerText:String = "default answer"
    var scribble_img = UIImage(systemName: "house")!
    
    var hasImage = false
    
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
            
            if !hasImage{
                scribble_view.isHidden = true
                
                
                
                if let myConstraint = backLabel.constraints.first(where: {$0.identifier == "height"}){
                    myConstraint.constant = 200
                }
//
//                let heightConstraint = NSLayoutConstraint(item: backLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 500)
//                backLabel.addConstraint(heightConstraint)
                
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
