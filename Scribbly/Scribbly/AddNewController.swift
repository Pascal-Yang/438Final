//
//  AddNewController.swift
//  Scribbly
//
//  Created by JingYuan on 2022/11/13.
//

import Foundation
import UIKit

class AddNewController: UIViewController{
    
    var imageAdded = false
    
    var CardList:[FlashCard] = []
    
    var courseKey:String = ""
    
    @IBOutlet weak var button: UIButton!
    
    var scribble_image:UIImage? = UIImage(systemName: "highlighter")!
    
    override func viewDidLoad() {
        print("addNewController loaded with courseKey=\(courseKey)")
    
        super.viewDidLoad()
        
        background_view.layer.cornerRadius = 30
        background_view.layer.borderWidth = 2
        background_view.layer.borderColor = MyColor.green2.cgColor
        scribble.layer.cornerRadius = 20
        scribble.layer.borderColor = MyColor.green1.cgColor
        scribble.layer.borderWidth = 2
        scribble.layer.masksToBounds = true
        scribble.layer.backgroundColor = MyColor.blue1.cgColor
        button.titleLabel?.font = Font.H1
    }
    

    @IBOutlet weak var background_view: UIView!
    
    @IBOutlet weak var termInfo: UILabel!
    
    @IBOutlet weak var termContent: UITextField!
    
    @IBOutlet weak var scribble: UIImageView!
    
    @IBOutlet weak var definitionInfo: UILabel!
    
    @IBOutlet weak var definitionContent: UITextField!
    
    
    @IBAction func saveNewCard(_ sender: Any) {
        let termText = termContent.text!
        let definitionText = definitionContent.text!
        CardList = fetchAllCards()
        
        var tx = FlashCard(frontTxt: termText, backTxt: definitionText, scribble:scribble_image!, id: CardList.count+1)
        tx.hasImage = imageAdded
        
        CardList.append(tx)
        termContent.text = ""
        definitionContent.text = ""
        saveCards()
        let message = UIAlertController(title: "Success", message: "The new term has been added to the course", preferredStyle: .alert)
        message.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(message, animated: true, completion: nil)
    }
    
    func fetchAllCards()->[FlashCard]{
        
        if let fetchdata = UserDefaults.standard.data(forKey: courseKey) {
            
            do {
                let decoder = JSONDecoder()
                let folder:Folder = try decoder.decode(Folder.self, from: fetchdata)
                let cards = folder.CardList
                return cards
            } catch {
                print("Unable to Decode Folder")
            }
        }
        
        let message = UIAlertController(title: "Error", message: "The course does not exist", preferredStyle: .alert)
        message.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(message, animated: true, completion: nil)
        return []
    }
    
    func saveCards(){
        
        
        var Folder1 = Folder(CardList: CardList, name: courseKey, progress: Double.random(in: 0.2 ..< 0.8))
        
        //update progress
        var count = 0.0
        for card in CardList{
            if card.learned{
                count += 1
            }
        }
        Folder1.progress = count / Double(Folder1.CardList.count)
        
        do {
            let encoder = JSONEncoder()
            let toInsert = try encoder.encode(Folder1)
            UserDefaults.standard.set(toInsert, forKey: courseKey)
        } catch {
            print("Unable to Encode Array of Folders (\(error))")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scribble.image = scribble_image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scribble.image = scribble_image
    }
    
    
}
