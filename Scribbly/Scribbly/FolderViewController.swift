//
//  DetailViewController.swift
//  Scribbly
//
//  Created by Jingyuan Zhu on 11/2/22.
//

import UIKit

class FolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func AddNewTapped(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let addNewViewController = mainStoryboard.instantiateViewController(withIdentifier: "AddNewController") as? AddNewController else{
            print("Couldn't find view controller")
            return
        }
        print("going to addNew with key=\(courseKey)")
        addNewViewController.courseKey = self.courseKey
        navigationController?.pushViewController(addNewViewController, animated: true)
    }
    
    @IBAction func StartLearningTapped(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let displayViewController = mainStoryboard.instantiateViewController(withIdentifier: "display") as? DisplayViewController else{
            print("Couldn't find view controller")
            return
        }
        print("going to displayView with key=\(courseKey)")
        displayViewController.courseKey = courseKey
        navigationController?.pushViewController(displayViewController, animated: true)
    }
    
    var courseKey:String = "ECON 1011: Micro Econ"
    var data:[FlashCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = MyColor.darkBlue
        tableView.delegate = self
        tableView.dataSource = self
        
        var tempCardList:[FlashCard] = []
        
        // test values
        let t1 = FlashCard(frontTxt: "opportunity cost", backTxt: "the loss of potential gain from other alternatives when one alternative is chosen.", id: 1, learned: false)
        
        let t2 = FlashCard(frontTxt: "microeconomics",backTxt: "the part of economics concerned with single factors and the effects of individual decisions.",id: 2, learned: false)
        let t3 = FlashCard(frontTxt: "labor force",backTxt: " the sum of employed and unemployed persons",id:3, learned: false)
        
        tempCardList = [t1,t2,t3]
        
        let Folder1 = Folder(CardList: tempCardList, name: courseKey, progress: 0)
        

        do {
            let encoder = JSONEncoder()
            let toInsert = try encoder.encode(Folder1)
            UserDefaults.standard.set(toInsert, forKey: courseKey)
        } catch {
            print("Unable to Encode Array of Folders (\(error))")
        }
        
        data = fetchAllCards()
        
        tableView.reloadData()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("table will appear")
        data = fetchAllCards()
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FolderTableViewCell

        cell.term.text = data[indexPath.row].FrontText
        cell.definition.text = data[indexPath.row].BackText
        cell.backgroundColor = UIColor.clear
        cell.term.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.definition.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.term.textColor = UIColor.white
        cell.definition.textColor = UIColor.white
        cell.definition.backgroundColor = MyColor.darkBlue
        cell.term.layer.zPosition = 10
        cell.backgroundColor = UIColor.clear
        cell.contentView.layer.borderWidth = 1
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
  
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
   

}
