//
//  ReusableValues.swift
//  Scribbly
//
//  Created by Zhiyi Tang on 11/6/22.
//

import Foundation
import UIKit

public enum MyColor {
    static let green1 = #colorLiteral(red: 0.8537771702, green: 0.9962138534, blue: 0.8406556249, alpha: 1)
    static let green2 = #colorLiteral(red: 0.5164914131, green: 0.8128321171, blue: 0.4899054766, alpha: 1)
    static let green3 = #colorLiteral(red: 0.3741974235, green: 0.741466403, blue: 0.329223156, alpha: 1)
    static let darkBlue = #colorLiteral(red: 0.1717210114, green: 0.2214289904, blue: 0.3770936131, alpha: 1)
    static let blue1 = #colorLiteral(red: 0.172457695, green: 0.2236871719, blue: 0.3749298453, alpha: 1)
    static let grey = #colorLiteral(red: 0.8206393123, green: 0.8206391931, blue: 0.8206391931, alpha: 1)

}

public enum Font {
    static let H1 = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let H2 = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let Body = UIFont.systemFont(ofSize: 14, weight: .medium)
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

public func defaultUserFolders() {
    var not_set = true
    if(curUser == "test" && not_set){
        let f1 = FolderInfo(name: "ECON 1011: Micro Econ", owner: "test", progress: 0.0)
        let f2 = FolderInfo(name: "CSE 417: Machine Learning", owner: "test", progress: 0.0)
        let f3 = FolderInfo(name: "Math 415: Partial Differential Equation", owner: "test", progress: 0.0)
        let f4 = FolderInfo(name: "Math 493: Probability", owner: "test", progress: 0.0)
        let testFolderVal:[FolderInfo] = [f1,f2,f3,f4]
        
        
        if let data = UserDefaults.standard.data(forKey: "folders") {
            do {
                let decoder = JSONDecoder()
                let allFolders = try decoder.decode([FolderInfo].self, from: data)
                for f in allFolders{
                    if(f.owner == "test"){
                        not_set = false
                    }
                }
            } catch {
                print("Unable to Decode FolderInfo (\(error))")
            }
        }
        
        if(not_set){
        
        do {
                 let encoder = JSONEncoder()
                 let data = try encoder.encode(testFolderVal)
                 UserDefaults.standard.set(data, forKey: "folders")
             } catch {
                 print("Unable to Encode Array of FolderInfos (\(error))")
             }
        
        }
        
    }
    else{
        //do nothing
    }
    UserDefaults.standard.set(false, forKey: "setBool")
}

public func defaultUserFlashCards() {
    //  test values
    var not_set = true
    if(curUser == "test" && not_set){
      let Micro1 = FlashCard(frontTxt: "opportunity cost", backTxt: "the loss of potential gain from other alternatives when one alternative is chosen.", scribble:UIImage(named: "opportunityCost")!, id: 1, learned: false)
    
      let Micro2 = FlashCard(frontTxt: "micro economics",backTxt: "the part of economics concerned with single factors and the effects of individual decisions.", scribble:UIImage(systemName: "house")!, id: 2, learned: false)
    
      let Micro3 = FlashCard(frontTxt: "labor force",backTxt: "all the members of a particular organization or population who are able to work", scribble:UIImage(systemName: "house")!, id:3, learned: false)
    
            let MicroEconCardList:[FlashCard] = [Micro1,Micro2, Micro3]
            let Folder1 = Folder(CardList: MicroEconCardList, name: "ECON 1011: Micro Econ", progress: 0)
    
            do {
                let encoder = JSONEncoder()
                let toInsert = try encoder.encode(Folder1)
                UserDefaults.standard.set(toInsert, forKey: "ECON 1011: Micro Econ")
            } catch {
                print("Unable to Encode Array of Folders (\(error))")
            }
        
        let PDE1 = FlashCard(frontTxt: "Green's Function", backTxt: "Solution of the Poisson equation in a domain.", scribble:UIImage(named: "GreenFunction")!, id: 1, learned: false)
    
        let PDE2 = FlashCard(frontTxt: "Fundamental Solution", backTxt: "Used to build solutioin in Rn for Laplace Equation", scribble:UIImage(named: "dog")!, id: 2, learned: false)
    
       let PDECardList:[FlashCard] = [PDE1, PDE2]
 
       let Folder3 = Folder(CardList: PDECardList, name: "Math 415: Partial Differential Equation", progress: 0)
 
         do {
             let encoder = JSONEncoder()
             let toInsert = try encoder.encode(Folder3)
             UserDefaults.standard.set(toInsert, forKey: "Math 415: Partial Differential Equation")
         } catch {
             print("Unable to Encode Array of Folders (\(error))")
         }
    
        let ML1 = FlashCard(frontTxt: "key assumption of ML", backTxt: "Training data points and test data points are i.i.d. drawn from hte same distribution.", scribble:UIImage(named: "dog")!, id: 1, learned: false)
        let ML2 = FlashCard(frontTxt: "Hoeffding's Inequality", backTxt: "", scribble:UIImage(named: "dog")!, id: 2, learned: false)

        let MLCardList:[FlashCard] = [ML1, ML2]

        let Folder2 = Folder(CardList: MLCardList, name: "CSE 417: Machine Learning", progress: 0)
        
        if let data = UserDefaults.standard.data(forKey: "folders") {
            do {
                let decoder = JSONDecoder()
                let allFolders = try decoder.decode([FolderInfo].self, from: data)
                for f in allFolders{
                    if(f.owner == "test"){
                        not_set = false
                    }
                }
            } catch {
                print("Unable to Decode FolderInfo (\(error))")
            }
        }
        
        if(not_set){
            do {
             let encoder = JSONEncoder()
             let toInsert = try encoder.encode(Folder2)
             UserDefaults.standard.set(toInsert, forKey: "CSE 417: Machine Learning")
            } catch {
             print("Unable to Encode Array of Folders (\(error))")
            }
        
            let P1 = FlashCard(frontTxt: "", backTxt: ".", scribble:UIImage(named: "dog")!, id: 1, learned: false)
            let P2 = FlashCard(frontTxt: "", backTxt: "", scribble:UIImage(named: "dog")!, id: 2, learned: false)

        let PCardList:[FlashCard] = [P1, P2]

        let Folder4 = Folder(CardList: PCardList, name: "Math 493: Probability", progress: 0)

        do {
         let encoder = JSONEncoder()
         let toInsert = try encoder.encode(Folder4)
         UserDefaults.standard.set(toInsert, forKey: "Math 493: Probability")
        } catch {
         print("Unable to Encode Array of Folders (\(error))")
        }

        }

                
    }
    
}
        
func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
}
    
}

