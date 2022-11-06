//
//  DetailViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit

class FolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var flashcards = [FlashCard]()
    
    var CardList:[FlashCard] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.backgroundColor = MyColor.darkBlue
        tableView.delegate = self
        tableView.dataSource = self
        // test values
        let t1 = FlashCard(FrontText: "opportunity cost", BackText: "the loss of potential gain from other alternatives when one alternative is chosen.", id: 1)
        
        let t2 = FlashCard(FrontText: "microeconomics",BackText: "the part of economics concerned with single factors and the effects of individual decisions.",id: 2)
        let t3 = FlashCard(FrontText: "labor force",BackText: " the sum of employed and unemployed persons",id:3)
        
        CardList = [t1,t2,t3]
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(CardList)
            UserDefaults.standard.set(data, forKey: "flashcards")
        } catch {
            print("Unable to Encode Array of Flashcards (\(error))")
        }

        // grab local data from userdefaults.standard
        if let data = UserDefaults.standard.data(forKey: "flashcards") {
            do {
                let decoder = JSONDecoder()
                flashcards = try decoder.decode([FlashCard].self, from: data)
            } catch {
                print("Unable to Decode Flashcards(\(error))")
            }
        }
        
        tableView.reloadData()
        
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FolderTableViewCell

        cell.term.text = CardList[indexPath.row].FrontText
        cell.definition.text = CardList[indexPath.row].BackText
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
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CardList.remove(at: indexPath.row)
//            Utility.saveToUserDefaultsFavorite(movies: movies, self, "Movie deleted from favroites")
        }
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) { // add swipe to delete to each row, reload data if delete performed
//            let section = sections[indexPath.section]
//            folders.removeAll(where: {$0.name == section.savedFolders[indexPath.row].name})
//            do {
//                let encoder = JSONEncoder()
//                let data = try encoder.encode(folders)
//                UserDefaults.standard.set(data, forKey: "folders")
//            } catch {
//                print("Unable to Encode Array of Folders (\(error))")
//            }
//
//        }
//    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
//    var items: [FlashCard] = getFromUserDefaultsItems() {
//        didSet {
//          // incomplete
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }

    
    func saveToUserDefaultsCourse(items: [FlashCard], _ viewController: UIViewController, _ message: String = "Item added to the course") {

        // incomplete
        
        showMessage(viewController, "Success!", message)
    }

    
    
    // deletion
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            movies.remove(at: indexPath.row)
//            Utility.saveToUserDefaultsFavorite(movies: movies, self, "Movie deleted from favroites")
//        }
//    }
    
    func showMessage(_ viewController: UIViewController, _ title: String, _ content: String, _ handler: ((UIAlertAction) -> Void)? = nil) {
        let message = UIAlertController(
            title: title,
            message: content,
            preferredStyle: .alert
        )
        message.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: handler
            )
        )
        viewController.present(message, animated: true)
    }
    



}
    

