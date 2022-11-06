//
//  Course.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import Foundation

//class Folder{
//
//    var CardList:[FlashCard] = []
//    var name:String!
//    //var owner:String!
//
//    init(name:String){
//        self.name = name
//    }
//
//}

struct Folder: Codable {
    var CardList:[FlashCard] = []
    var term:String = "termName"
    //var owner:String!
    var definition:String = "definition"
    var progress:Double = 0
}

