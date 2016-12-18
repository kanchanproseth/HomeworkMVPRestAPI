//
//  ManpulatePresenter.swift
//  RestMVP
//
//  Created by Kan Chanproseth on 12/16/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import Foundation
import UIKit
var imageString :String?
class ManipulatePresenter{
    var ManipulateModels:ManipulateModel?
    var ManipulateViewInterface:ManipulateProtocol?
    
    func LoadManipulateView(viewInterface: ManipulateProtocol) {
        
        
        //set delegate
        self.ManipulateViewInterface = viewInterface
        ManipulateModels = ManipulateModel()
        ManipulateModels?.ManipulatePresenterInterface = self
        
        
        //notify to the caller
        ManipulateViewInterface?.LoadManipulateView()
    }
    func PostImageData(title:String , descriptionsOfPost: String,image: Data){
        print("1******\(image)")
        ManipulateModels?.uploadImage(title,descriptionsOfPost,image)
    }
    func delete(id: Int){
        ManipulateModels?.delete(id: id)
    }
}
extension ManipulatePresenter:ManipulatePresenterProtocol{
    func responeImageData(title:String , descriptionsOfPost: String,data: String) {
        imageString = data
        print("aksjdlkajsdiodjqwijiahsoidualskdjasdhkjashdkjasdlkashd****************************************************************\(data)")
        ManipulateModels?.PostArticleData(title, descriptionsOfPost, image: data)
    }
}
