//
//  DisplayViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/3/22.
//

import UIKit

class DisplayViewController: UIViewController {
    

    @IBOutlet weak var progressBar: DisplayView!
    @IBOutlet weak var learnedButton: UIButton!
    @IBOutlet weak var CardPageView: UIView!
    
    var currentIndex:Int = 0 {
        didSet{
            print("index: \(currentIndex)")
        }
    }
    
    var data:[FlashCard] = []
    
    var courseKey:String = "xxx"
    
    var ratio:Double = 0 {
        didSet{
            progressBar.animateValue(to: CGFloat(ratio))
            if ratio >= 0.94{
                progressBar.backgroundColor = MyColor.green3
            }else{
                progressBar.backgroundColor = MyColor.green1
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.color = MyColor.green3
        progressBar.backgroundColor = MyColor.grey
        
        
        progressBar.layer.cornerRadius = 15
        progressBar.valueView.layer.cornerRadius = 15
        progressBar.valueView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        data = fetchAllCards()
        
        if data.count < 1{
            
        }else{
            configPageView()
        }
        
    }
    
    func scaleRatio(rawRatio:Double)->Double{
        
        var res = 0.0
        
        if rawRatio == 0{
            res = 0.0
        }else{
            res = 0.06 + (rawRatio * (0.94-0.06))
        }
        
        return res
    }
    
    // update the learn status of data and record it to userdefault
    func updateCardData(learned:Bool, index:Int){
        
        data[index].learned = learned
        var finishCount = 0.0
        for card in data{
            if card.learned{
                finishCount += 1
            }
        }
        
        var finishRatio:Double = data.count == 0 ? 0 : finishCount/Double(data.count)
        finishRatio = scaleRatio(rawRatio: finishRatio)
        
        
        self.ratio = finishRatio
        
        print("Progress updated to \(finishRatio) at \(courseKey)")
        
        // update progresss of the folder itself
        let v1 = Folder(CardList: data, name: courseKey, progress: finishRatio)
        do {
            let encoder = JSONEncoder()
            let toInsert = try encoder.encode(v1)
            UserDefaults.standard.set(toInsert, forKey: courseKey)
        } catch {
            print("Unable to Encode Array of Folders (\(error))")
        }
        
        // update progress of the folder in folderInfo array
        if let data = UserDefaults.standard.data(forKey: "folders") {
            var toEncodeFolders:[FolderInfo] = []
            do {
                let decoder = JSONDecoder()
                var allFolders = try decoder.decode([FolderInfo].self, from: data)
                let targetFolderIndex = allFolders.firstIndex{$0.name == courseKey}
                allFolders[targetFolderIndex!].progress = finishRatio
                toEncodeFolders = allFolders
            } catch {
                print("Unable to Decode FolderInfo (\(error))")
            }
            
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(toEncodeFolders)
                UserDefaults.standard.set(data, forKey: "folders")
            } catch {
                print("Unable to Encode Array of FolderInfos (\(error))")
            }
        
        }
        
        
        
    }
    
    @IBAction func learnedButtonClicked(_ sender: Any) {
        updateCardData(learned: !data[currentIndex].learned, index: currentIndex)
        
        //check if learned
        if data[currentIndex].learned{
            learnedButton.tintColor = MyColor.green2
            learnedButton.setTitle("uncheck", for: .normal)
        }else{
            learnedButton.tintColor = MyColor.grey
            learnedButton.setTitle("check", for: .normal)
        }
    }
    
    
    func fetchAllCards()->[FlashCard]{
        
        print("fetching key: \(courseKey)")
        
        if let fetchdata = UserDefaults.standard.data(forKey: courseKey) {
            
            do {
                let decoder = JSONDecoder()
                let folder:Folder = try decoder.decode(Folder.self, from: fetchdata)
                let cards = folder.CardList
                self.ratio = folder.progress
                return cards
            } catch {
                print("Unable to Decode Folder")
            }
            
        }
        
        let message = UIAlertController(title: "Error", message: "The course key is not in userDefault", preferredStyle: .alert)
        message.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(message, animated: true, completion: nil)
        return []
    }
    
    func configPageView(){
        
        // create a pageView instance and add to the CardPage View
        guard let pageView = storyboard?.instantiateViewController(withIdentifier: "page") as? MyPageViewController else{
            return
        }
        pageView.delegate = self
        pageView.dataSource = self
       
        // add pageView as subview
        addChild(pageView)
        pageView.didMove(toParent: self)
        //pageView.view.layer.cornerRadius = 50
        pageView.view.clipsToBounds = false
        CardPageView.addSubview(pageView.view)
        CardPageView.layer.cornerRadius = 50
        pageView.view.frame = CardPageView.bounds
        
        // add the initial page to pageView
        guard let dataView = CreateDataViewAtIndex(index: currentIndex) else{return}
        
        //check if learned
        if data[currentIndex].learned{
            learnedButton.tintColor = MyColor.green2
            learnedButton.setTitle("uncheck", for: .normal)
        }else{
            learnedButton.tintColor = MyColor.grey
            learnedButton.setTitle("check", for: .normal)
        }
        
        pageView.setViewControllers([dataView], direction: .forward, animated: true)
        
    }
    
    
    func CreateDataViewAtIndex(index:Int) -> DataViewController?{
        
        if index >= data.count || data.count == 0{
            return nil
        }
        
        guard let dataView = storyboard?.instantiateViewController(withIdentifier: "data") as? DataViewController else{
            return nil
        }
        
        dataView.questionText = data[index].FrontText
        dataView.answerText = data[index].BackText
        dataView.index = index
        dataView.scribble_img = UIImage(data: data[index].photo_data)!
        dataView.hasImage = data[index].hasImage
        
        
        
        //check if learned
        if data[index].learned{
            learnedButton.tintColor = MyColor.green2
            learnedButton.setTitle("uncheck", for: .normal)
        }else{
            learnedButton.tintColor = MyColor.grey
            learnedButton.setTitle("check", for: .normal)
        }
        
        return dataView
    }
    
   

}

extension DisplayViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    // go to the last page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let previousView = viewController as? DataViewController else {return nil}
        
        let index = previousView.index
        
        if index <= 0{
            currentIndex = 0
            return nil
        }
        
        currentIndex = index - 1
        
        return CreateDataViewAtIndex(index: currentIndex)
        
    }
    
    // go to the next page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let previousView = viewController as? DataViewController else {return nil}
        
        let index = previousView.index
        
        if index >= data.count-1{
            return nil
        }
        
        currentIndex = index + 1
        
        return CreateDataViewAtIndex(index: currentIndex)
    }
    
    
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.data.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
}
