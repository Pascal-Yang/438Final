//
//  File.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import Foundation

struct FlashCard: Codable{
    
    /*TODO
     1. add var for the canvas view
     2. look for static id increment
     */
    
    var FrontText:String = "default front text"
    var BackText:String = "default back text"
    var id:Int!
    
    init(frontTxt:String, backTxt:String, id:Int){
        FrontText = frontTxt
        BackText = backTxt
        self.id = id
    }
    
}

