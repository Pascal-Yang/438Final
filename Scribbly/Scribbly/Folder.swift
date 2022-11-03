//
//  Course.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import Foundation

class Folder{
    
    var CardList:[FlashCard] = []
    var name:String!
    //var owner:String!
    var progres:Int = 0
    
    init(name:String){
        self.name = name
    }
    
}

