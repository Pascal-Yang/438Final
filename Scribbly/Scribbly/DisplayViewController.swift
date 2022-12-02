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
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.color = MyColor.green3
        progressBar.backgroundColor = MyColor.grey
        
        
        // get fake cards
//        var tempCards:[FlashCard] = []
//        for i in 1...5{
//            tempCards.append(FlashCard(frontTxt: courseKey + "Question \(i)",
//                                       backTxt: "Answer \(i)",
//                                       id: i,
//                                       learned: (i%2==0))
//            )
//
//        }
//
//        // create a fake folder
//        let v1 = Folder(CardList: tempCards, name: "ECON 1011: Micro Econ", progress: Double.random(in: 0.2 ..< 0.8))
//
//        do {
//            let encoder = JSONEncoder()
//            let toInsert = try encoder.encode(v1)
//            UserDefaults.standard.set(toInsert, forKey: "ECON 1011: Micro Econ")
//        } catch {
//            print("Unable to Encode Array of Folders (\(error))")
//        }
        
        data = fetchAllCards()
        
        if data.count < 1{
            
        }else{
            configPageView()
        }
        
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
        let finishRatio:Double = finishCount/Double(data.count)
        
        self.ratio = finishRatio
        
        var v1 = Folder(CardList: data, name: courseKey, progress: finishRatio)
        do {
            let encoder = JSONEncoder()
            let toInsert = try encoder.encode(v1)
            UserDefaults.standard.set(toInsert, forKey: courseKey)
        } catch {
            print("Unable to Encode Array of Folders (\(error))")
        }
    }
    
    @IBAction func learnedButtonClicked(_ sender: Any) {
        updateCardData(learned: !data[currentIndex].learned, index: currentIndex)
        
        //check if learned
        if data[currentIndex].learned{
            learnedButton.tintColor = MyColor.green2
        }else{
            learnedButton.tintColor = MyColor.grey
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
        }else{
            learnedButton.tintColor = MyColor.grey
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
        
        //check if learned
        if data[index].learned{
            learnedButton.tintColor = MyColor.green2
        }else{
            learnedButton.tintColor = MyColor.grey
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
