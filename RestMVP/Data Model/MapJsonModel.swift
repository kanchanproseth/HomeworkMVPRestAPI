//
//  MapJsonModel.swift
//  RestMVP
//
//  Created by Cyberk on 12/13/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import Foundation


class Category {
    var id:Int?
    var name:String?
    
}

class Author {
    var id:Int?
    var name:String?
    var gender:String?
    var email:String?
}

class Article{
    var id:Int?
    var title:String?
    var image:String?
    var description:String?
    var totalPage:Int?
    var category:Category?
    var author:Author?
}


