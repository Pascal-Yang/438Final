//
//  DetailViewController.swift
//  Scribbly
//
//  Created by Jingyuan Zhu on 11/2/22.
//

import UIKit

class FolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selected_index = 0
    var img:UIImage = UIImage(systemName: "house")!
    var term: String = ""
    var def: String = ""
    
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
    
//    @IBAction func StartLearningTapped(_ sender: Any) {
//        print("reload...")
//        tableView.reloadData()
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let displayViewController = mainStoryboard.instantiateViewController(withIdentifier: "display") as? DisplayViewController else{
//            print("Couldn't find view controller")
//            return
//        }
//        print("going to displayView with key=\(courseKey)")
//        displayViewController.courseKey = courseKey
//        navigationController?.pushViewController(displayViewController, animated: true)
//    }
    
    var courseKey:String = "ECON 1011: Micro Econ"
    var data:[FlashCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        self.tableView.backgroundColor = MyColor.blue1
        tableView.delegate = self
        tableView.dataSource = self
        
        //var tempCardList:[FlashCard] = []
        
//        // test values
//        let t1 = FlashCard(frontTxt: "opportunity cost", backTxt: "the loss of potential gain from other alternatives when one alternative is chosen.", scribble:UIImage(named: "dog")!, id: 1, learned: false)
//
//        let t2 = FlashCard(frontTxt: "micro economics",backTxt: "the part of economics concerned with single factors and the effects of individual decisions.", scribble:UIImage(systemName: "house")!, id: 2, learned: false)
//        let t3 = FlashCard(frontTxt: "labor force with many unnecessary words added to this lable",backTxt: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", scribble:UIImage(named: "dog")!, id:3, learned: false)
//
//        tempCardList = [t1,t2,t3]
//
//        let Folder1 = Folder(CardList: tempCardList, name: courseKey, progress: 0)
//
//
//        do {
//            let encoder = JSONEncoder()
//            let toInsert = try encoder.encode(Folder1)
//            UserDefaults.standard.set(toInsert, forKey: courseKey)
//        } catch {
//            print("Unable to Encode Array of Folders (\(error))")
//        }
        
        defaultUserFlashCards()
        data = fetchAllCards()
        
        tableView.reloadData()
        
    }

    func fetchAllCards()->[FlashCard]{
        var cards:[FlashCard] = []
        if let fetchdata = UserDefaults.standard.data(forKey: courseKey) {
            do {
                let decoder = JSONDecoder()
                let folder:Folder = try decoder.decode(Folder.self, from: fetchdata)
                cards = folder.CardList
            } catch {
                print("Unable to Decode Folder")
            }
        }else{
            // save changes to backend
            let newFolder = Folder(CardList: [], name: courseKey, progress: 0)
            // save to DB
            do {
                let encoder = JSONEncoder()
                let toInsert = try encoder.encode(newFolder)
                UserDefaults.standard.set(toInsert, forKey: courseKey)
            } catch {
                print("Unable to Encode Array of Folders (\(error))")
            }
            cards = []
        }
        return cards
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("table will appear")
        data = fetchAllCards()
        tableView.reloadData()
        
        for card in data{
            if !card.hasImage{
                print("no scribble")
            }else{
                print("scribble")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if data[indexPath.row].photo_data == UIImage(systemName: "house")?.pngData(){
        if data[indexPath.row].hasImage == false{
            
            print("\(data[indexPath.row].FrontText) image = \(data[indexPath.row].hasImage)")
            // without image
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithoutImage", for: indexPath) as! FolderTableViewCellWithoutImage
            //set text contents
            cell.term.text = data[indexPath.row].FrontText
            cell.definition.text = data[indexPath.row].BackText
            
            // layout
            cell.container.layer.borderColor = MyColor.green1.cgColor
            return cell
            
        }else{
            print("\(data[indexPath.row].FrontText) image = \(data[indexPath.row].hasImage)")
            // with image
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FolderTableViewCell
            // set text contents
            cell.term.text = data[indexPath.row].FrontText
            cell.definition.text = data[indexPath.row].BackText
            cell.scribble.image = UIImage(data: data[indexPath.row].photo_data)
            

            // layout
            cell.container.layer.borderColor = MyColor.green1.cgColor
            return cell
        }
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !data[indexPath.row].hasImage{
            return 150
        }else{
            return 350
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit  = UIContextualAction(style: .normal, title: "Edit") { [self]
            _,_,_ in print("edit tapped")
            self.selected_index = indexPath.row
            self.img = UIImage(data: data[indexPath.row].photo_data)!
            self.term = data[indexPath.row].FrontText
            self.def = data[indexPath.row].BackText
            let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
            secondViewController.index = self.selected_index
            secondViewController.scribble_image = self.img
            secondViewController.term = self.term
            secondViewController.content = self.def
            secondViewController.courseKey = self.courseKey
            self.navigationController!.pushViewController(secondViewController, animated: true)
            
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self]
            _,_,_ in
            print("delete tapped")
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            var newFolder = Folder(CardList: data, name: courseKey, progress: Double.random(in: 0.2 ..< 0.8))
            if data.count == 0{
                            newFolder.progress = 0
                        }else{
                            //update progress
                            var count = 0.0
                            for card in data{
                                if card.learned{
                                    count += 1
                                }
                            }
                            newFolder.progress = count / Double(data.count)
                        }
            
            
                        // save to DB
                        do {
                            let encoder = JSONEncoder()
                            let toInsert = try encoder.encode(newFolder)
                            UserDefaults.standard.set(toInsert, forKey: courseKey)
                        } catch {
                          print("Unable to Encode Array of Folders (\(error))")
                        }
            
        }
            
        let swipeConfig = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipeConfig
            
    }
    

        
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//
//            print("removing card at index \(indexPath.row)")
//
//
//            data.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            print(data)
//
//
//            // save changes to backend
//            var newFolder = Folder(CardList: data, name: courseKey, progress: Double.random(in: 0.2 ..< 0.8))
//
//            if data.count == 0{
//                newFolder.progress = 0
//            }else{
//                //update progress
//                var count = 0.0
//                for card in data{
//                    if card.learned{
//                        count += 1
//                    }
//                }
//                newFolder.progress = count / Double(data.count)
//            }
//
//
//            // save to DB
//            do {
//                let encoder = JSONEncoder()
//                let toInsert = try encoder.encode(newFolder)
//                UserDefaults.standard.set(toInsert, forKey: courseKey)
//            } catch {
//                print("Unable to Encode Array of Folders (\(error))")
//            }
//
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let displayViewController = mainStoryboard.instantiateViewController(withIdentifier: "display") as? DisplayViewController else{
            print("Couldn't find view controller")
            return
        }
        displayViewController.currentIndex = indexPath.row
        displayViewController.courseKey = self.courseKey
        navigationController?.pushViewController(displayViewController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? EditViewController
        
        vc?.index = self.selected_index
        vc?.scribble_image = self.img
        vc?.term = self.term
        vc?.content = self.def
        print("here3")
    }
   

}
