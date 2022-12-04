//
//  File.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import Foundation
import SwiftUI

struct FlashCard: Codable{
    
    /*TODO
     1. add var for the canvas view
     2. look for static id increment
     */
    
    var FrontText:String = "default front text"
    var BackText:String = "default back text"
    var id:Int = -1
    var learned:Bool = false
    var photo_data: Data
    
    var hasImage:Bool = false
        

    init(frontTxt:String, backTxt:String, scribble: UIImage, id:Int){
        FrontText = frontTxt
        BackText = backTxt
        self.id = id
        self.photo_data = scribble.pngData()!
    }
    
    init(frontTxt:String, backTxt:String, scribble: UIImage, id:Int, learned:Bool){
        self.learned = learned
        FrontText = frontTxt
        BackText = backTxt
        self.id = id
        self.photo_data = scribble.pngData()!
    }
    
}

