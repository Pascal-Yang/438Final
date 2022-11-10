//
//  LibraryViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import UIKit
import EzPopup

struct Section {
    let letter : String
    let savedFolders : [FolderInfo]
}

var folders = [FolderInfo]()
var sections = [Section]()

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        let textAttributes = [NSAttributedString.Key.foregroundColor:MyColor.green1]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // make up test values and add to userDefault
        // TODO: TO-BE-REMOVED, replace storage method with database
        let v1 = FolderInfo(name: "ECON 1011: Micro Econ", progress: Double.random(in: 0.2 ..< 0.8))
        let v2 = FolderInfo(name: "PSYCH 360: Cognitive Psych", progress: Double.random(in: 0.2 ..< 0.8))
        let v3 = FolderInfo(name: "CSE 438: Mobile App", progress: Double.random(in: 0.2 ..< 0.8))
        let v4 = FolderInfo(name: "MATH 309: Matrix Algebra", progress: Double.random(in: 0.2 ..< 0.8))
        let v5 = FolderInfo(name: "ENGR 310: Tech Writing", progress: Double.random(in: 0.2 ..< 0.8))
        let v6 = FolderInfo(name: "ANTHRO 100: Intro to Human Evo", progress: Double.random(in: 0.2 ..< 0.8))
        let v7 = FolderInfo(name: "PSYCH 100: Intro to Psych", progress: Double.random(in: 0.2 ..< 0.8))
        let v8 = FolderInfo(name: "CSE 417: Machine Learning", progress: Double.random(in: 0.2 ..< 0.8))

        let testVal:[FolderInfo] = [v1, v2, v3, v4, v5, v6, v7, v8]

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(testVal)
            UserDefaults.standard.set(data, forKey: "folders")
        } catch {
            print("Unable to Encode Array of FolderInfos (\(error))")
        }
    
        
        // grab local data from userdefaults.standard
        if let data = UserDefaults.standard.data(forKey: "folders") {
            do {
                let decoder = JSONDecoder()
                folders = try decoder.decode([FolderInfo].self, from: data)
            } catch {
                print("Unable to Decode FolderInfo (\(error))")
            }
        }
        sortSections()
    } 
    
    override func viewDidAppear(_ animated: Bool) {
        print("here!!!")
        sortSections()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let folder = section.savedFolders[indexPath.row] as FolderInfo
        print(String(folder.name))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].savedFolders.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LibraryTableViewCell
            
        let section = sections[indexPath.section]
        let folder = section.savedFolders[indexPath.row] as FolderInfo
        print(String(folder.name))
        cell.folderName.text = folder.name
        cell.progressBar.animateValue(to: folder.progress)
        cell.progressBar.color = MyColor.green3
        cell.backgroundColor = UIColor.clear
        cell.folderName.layer.zPosition = 10
        cell.folderName.textColor = MyColor.darkBlue
        cell.folderName.font = Font.H2
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2)
        cell.selectedBackgroundView = cellBGView

        return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: do something
        return
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) { // add swipe to delete to each row, reload data if delete performed
            let section = sections[indexPath.section]
            folders.removeAll(where: {$0.name == section.savedFolders[indexPath.row].name})
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(folders)
                UserDefaults.standard.set(data, forKey: "folders")
            } catch {
                print("Unable to Encode Array of FolderInfos (\(error))")
            }
            sortSections()
        }
    }
    
    func sortSections(){
        let sortDictionary = Dictionary(grouping: folders, by: {String($0.name.prefix(1))})
        let keys = sortDictionary.keys.sorted()
        sections = keys.map{ Section(letter: $0, savedFolders: (sortDictionary[$0]?.sorted(by: { $0.name < $1.name }))!) }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func addFolder(_ sender: Any) {
        let contentVC = PopUpViewController()
        let popupVC = PopupViewController(contentController: contentVC, popupWidth: 300, popupHeight: 200)
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 25
        popupVC.shadowEnabled = true
        present(popupVC, animated: true)
        sortSections()
    }
    
}
