//
//  ScribbleViewController.swift
//  Scribbly
//
//  Created by Oscar.Z on 2022/12/1.
//

import UIKit
import SwiftUI


extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class Canvas: UIView{
    
    var lineColor : UIColor = UIColor.red
    var lineWidth : CGFloat = 1
    
    var line = [CGPoint]()
    var lines = [[CGPoint]]()
    var string_line = [String]()
    var string_lines = [[String]]()
    var color_array = [UIColor]()
    var width_array = [CGFloat]()
    
    struct LineData: Decodable{
        let lines: [[CGPoint]]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
        string_lines.append([String]())
        color_array.append(self.lineColor)
        width_array.append(self.lineWidth)
    }
    
    var url:URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory.appendingPathComponent("ECON-1777").appendingPathExtension("json")
    }
    
    func convert(){
        self.lines = []
        for l in string_lines{
            var temp_lines = [CGPoint]()
            for p in l{
                temp_lines.append(NSCoder.cgPoint(for: p))
            }
            lines.append(temp_lines)
        }
        setNeedsDisplay()
    }
    
    func loadData(){
        
        if let temp = NSArray(contentsOf: url) {
             self.string_lines = (temp as? [[String]])!
            }
       
        //let data = (try?Data(contentsOf: url))!
        //let decoder = JSONDecoder()
        //do{
          //  let linesData = try decoder.decode(LineData.self, from: data)
            //print(linesData)
            //self.lines = linesData.lines
        //}
        //catch{
          //  print("\(error)")
       // }
        convert()
        setNeedsDisplay()
    }
    
    func saveData(){
        //let encoder = JSONEncoder()
        //let data = try? encoder.encode(self.lines)
        do{
            try (self.string_lines as NSArray).write(to: url)
        }
        catch{
            print("\(error)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {return}
        guard var lastline = lines.popLast() else{return}
        guard var string_lastline = string_lines.popLast() else{return}
        
        let string_point = NSCoder.string(for: point)
        
        lastline.append(point)
        string_lastline.append(string_point)
        
        lines.append(lastline)
        string_lines.append(string_lastline)
        
        setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else{return}
        
        var k = 0
        
        lines.forEach { (line) in
            for (i,p) in line.enumerated(){
                if(color_array.count == 0){
                    context.setStrokeColor(self.lineColor.cgColor)
                }
                else{
                    context.setStrokeColor(color_array[k].cgColor)
                }
                context.setLineWidth(self.lineWidth)
                context.setLineCap(.butt)
                if i==0{
                    context.move(to: p)
                }else{
                    context.addLine(to: p)
                }
               
        }
            context.strokePath()
            k = k + 1
        }
                    
        
        
        
        
    }
     
        
}

extension ScribbleViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        (viewController as? AddNewController)?.scribble_image = image // Here you pass the to your original view controller
        print("set")
    }
}



class ScribbleViewController: UIViewController {
    var image = UIImage(systemName: "house")!
    
    let canvas = Canvas()
    
    let colorWell : UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.supportsAlpha = true
        colorWell.selectedColor = UIColor.red
        colorWell.title = "Line Color"
        return colorWell
        
    }()
    
    let size_picker : UISlider = {
        let size_picker = UISlider()
        size_picker.minimumValue = 1
        size_picker.maximumValue = 10
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
    
    override func viewDidLoad() {
        navigationController?.delegate = self
        super.viewDidLoad()
        CanvasView.addSubview(canvas)
        canvas.frame = CanvasView.frame
        canvas.backgroundColor = UIColor.gray
        panelView.addSubview(colorWell)
        sliderView.addSubview(size_picker)
        view.backgroundColor = MyColor.darkBlue
        
        colorWell.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        size_picker.addTarget(self, action: #selector(sizeChanged), for: .valueChanged)
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
