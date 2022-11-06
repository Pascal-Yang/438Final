//
//  Course.swift
//  Scribbly
//
//  Created by Pascal Yang on 11/2/22.
//

import Foundation

struct Folder: Codable {
    var CardList:[FlashCard] = []
    var name:String = "name"
    //var owner:String!
    var progress:Double = 0
}

