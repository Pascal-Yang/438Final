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
//    var progress:Double = 0
//
//    init(name:String){
//        self.name = name
//    }
//
//}

struct Folder: Codable {
    var CardList:[FlashCard] = []
    var name:String = "name"
    //var owner:String!
    var progress:Double = 0
}

struct FolderInfo: Codable {
    var name:String = "name"
    var owner:String = "someone"
    var progress:Double = 0
}


