//
//  EditScribbleViewController.swift
//  Scribbly
//
//  Created by Oscar.Z on 2022/12/4.
//

import UIKit
import SwiftUI

extension EditScribbleViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        (viewController as? EditViewController)?.scribble_image = image // Here you pass the to your original view controller
        (viewController as? EditViewController)?.imageAdded = true
        print("set")
    }
}


class EditScribbleViewController: UIViewController {

    var image = UIImage(systemName: "house")!
    
    let canvas = Canvas()
    
    let colorWell : UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.supportsAlpha = true
        colorWell.selectedColor = UIColor.white
        colorWell.title = "Line Color"
        return colorWell
        
    }()
    
    let size_picker : UISlider = {
        let size_picker = UISlider()
        size_picker.minimumValue = 1
        size_picker.maximumValue = 15
        return size_picker
    }()

    @IBOutlet weak var CanvasView: UIView!
    
    @IBOutlet weak var panelView: UIView!
    
    @IBOutlet weak var sliderView: UIView!
    
    @IBAction func didSave(_ sender: Any) {
        canvas.saveData()
        print("saved")
    }
    
    @objc private func colorChanged(){
        canvas.lineColor = colorWell.selectedColor!
    }
    
    @objc private func sizeChanged(){
        canvas.lineWidth = CGFloat(size_picker.value)
    }
    
 
    @IBAction func clearButton(_ sender: Any) {
        canvas.color_array = []
        canvas.width_array = []
        canvas.lines = []
        canvas.string_lines = []
        canvas.refresh()
    }
    
    @IBAction func didBack(_ sender: Any) {
        if(canvas.lines.count > 0){
        canvas.color_array.removeLast()
        canvas.width_array.removeLast()
        canvas.lines.removeLast()
        canvas.string_lines.removeLast()
        canvas.refresh()
        }
    }
   
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    override func viewDidLoad() {
        
        clearBtn.setImage(UIImage(systemName: "trash"), for: .normal)
        clearBtn.backgroundColor = UIColor.clear
        backBtn.setImage(UIImage(systemName: "arrow.uturn.left.circle"), for: .normal)

        
        navigationController?.delegate = self
        super.viewDidLoad()
        CanvasView.addSubview(canvas)
        
        panelView.addSubview(colorWell)
        
        sliderView.addSubview(size_picker)
        view.backgroundColor = MyColor.darkBlue
        
        CanvasView.backgroundColor = UIColor.clear
        panelView.backgroundColor = MyColor.darkBlue
        sliderView.backgroundColor = MyColor.darkBlue
        
        colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        size_picker.addTarget(self, action: #selector(sizeChanged), for: .valueChanged)
        
        CanvasView.layer.borderColor = UIColor(hue: 0.3389, saturation: 1, brightness: 0.69, alpha: 1.0).cgColor /* #00af05 */

        CanvasView.layer.borderWidth = CGFloat(4.0)
        CanvasView.layer.cornerRadius = CGFloat(20)
        
        canvas.frame = CanvasView.frame
        canvas.backgroundColor = MyColor.darkBlue
        
       
        
        canvas.center = CGPoint(x: CanvasView.frame.size.width  / 2,
                                     y: CanvasView.frame.size.height / 2)
        
        colorWell.center = CGPoint(x: panelView.frame.size.width  / 2,
                                     y: panelView.frame.size.height / 2)
        
        size_picker.center = CGPoint(x: sliderView.frame.size.width  / 2,
                                     y: sliderView.frame.size.height / 2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        image = canvas.asImage()
        print("disappear")
    }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


