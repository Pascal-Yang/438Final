//
//  EditFolderNameViewController.swift
//  Scribbly
//
//  Created by Zhiyi Tang on 11/9/22.
//

import UIKit

class EditFolderNameViewController: UIViewController {
    
    var input:UITextField?
    
    var curTable:UITableView?
    
    var prevFolder:FolderInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view
        let viewFrame = CGRect(x: 0, y: 0, width: 300, height: 200)
        let container = UIView(frame: viewFrame)
        container.backgroundColor = MyColor.green2
        view.addSubview(container)
        
        // setup textview
        let textFieldFrame = CGRect(x: 20, y: 75, width: 260, height: 34)
        input = UITextField(frame: textFieldFrame)
        input?.setLeftPaddingPoints(10)
        input?.setRightPaddingPoints(10)
        let placeholder = NSAttributedString(string: "Rename your folder", attributes: [NSAttributedString.Key.foregroundColor : MyColor.grey])
        input?.attributedText = placeholder
        input?.backgroundColor = UIColor.white
        input?.layer.cornerRadius = 5
        input?.addTarget(self, action: #selector(startType), for:  UIControl.Event.editingDidBegin)

        view.addSubview(input!)
        
        // setup label
        let labelFrame = CGRect(x: 82, y: 24, width: 150, height: 21)
        let label = UILabel(frame: labelFrame)
        label.text = "Edit Folder Name"
        label.font = Font.H1
        label.textColor = MyColor.darkBlue
        view.addSubview(label)
        
        // setup submit button
        let buttonFrame = CGRect(x: 20, y: 130, width: 260, height: 34)
        let button = UIButton(type: .system)
        button.frame = buttonFrame
        button.setTitle("Update", for: .normal)
        button.backgroundColor = MyColor.green1
        button.layer.cornerRadius = 5
        button.setTitleColor(MyColor.darkBlue, for: .normal)
        button.addTarget(self, action: #selector(editFolder), for: .touchUpInside)

        view.addSubview(button)
        
    }
    
    @objc func startType() {
        input?.text = ""
    }
    
    @objc func editFolder() {
        if let name = input?.text {
            
            // check if name is empty
            guard name != "" && name != "Name your folder" else {
                // TODO: print error message
                return
            }
            
            // check for name duplication
            for folder in folders {
                guard folder.name != name else {
                    return
                }
            }
    
            
            // add folder to array and rename corresponding folder
            do {
                if let data = UserDefaults.standard.data(forKey: "folders") {
                    do {
                        let decoder = JSONDecoder()
                        folders = try decoder.decode([FolderInfo].self, from: data)
                        folders.removeAll(where: {$0.name == prevFolder?.name})
                    } catch {
                        print("Unable to Decode FolderInfo (\(error))")
                    }
                }
                if var new = prevFolder {
                    new.name = name
                    folders.append(new)
                    print("new folder:", new)
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(folders)
                    UserDefaults.standard.set(data, forKey: "folders")
                    
                // TODO: change corresponding folder name
                }
            } catch {
                print("Unable to Encode Array of FolderInfos (\(error))")
            }

        
            self.view.isHidden = false
            self.dismiss(animated: true)
            
            // TODO: reload folder table

            folders = folders.filter{$0.owner == String(curUser)}
            let sortDictionary = Dictionary(grouping: folders, by: {String($0.name.prefix(1))})
            let keys = sortDictionary.keys.sorted()
            sections = keys.map{ Section(letter: $0, savedFolders: (sortDictionary[$0]?.sorted(by: { $0.name < $1.name }))!) }
            curTable?.reloadData()

        }
    }

}
