//
//  DisplayViewController.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/3/22.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var CardPageView: UIView!
    
    var currentIndex:Int = 0
    
    var data:[FlashCard] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for i in 1...5{
            data.append(FlashCard(frontTxt: "Ques \(i)", backTxt: "Ans \(i)", id: i))
        }
        
        configPageView()

        // Do any additional setup after loading the view.
    }
    
    func configPageView(){
        
       
        
        // create a pageView instance and add to the CardPage View
        guard let pageView = storyboard?.instantiateViewController(withIdentifier: "page") as? MyPageViewController else{
            return
        }
        pageView.delegate = self
        pageView.dataSource = self
       
        addChild(pageView)
        pageView.didMove(toParent: self)
        
        CardPageView.addSubview(pageView.view)
        
        pageView.view.frame = CardPageView.bounds
        
        // give pageView an initial dataView to display
        guard let dataView = storyboard?.instantiateViewController(withIdentifier: "data") as? DataViewController else{
            return
        }
        
        dataView.index = currentIndex
        dataView.questionText = data[currentIndex].FrontText
        dataView.answerText = data[currentIndex].BackText
        
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
        
        return dataView
    }
    
   

}

extension DisplayViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    // go to the last page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let previousView = viewController as? DataViewController else {return nil}
        
        let index = previousView.index
        
        if index <= 0{
            return nil
        }
        
        currentIndex = index - 1
        
        return CreateDataViewAtIndex(index: currentIndex)
        
    }
    
    // go to the next page
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let previousView = viewController as? DataViewController else {return nil}
        
        let index = previousView.index
        
        if index >= data.count{
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
