//
//  ArticlePresenter.swift
//  RestMVP
//
//  Created by Cyberk on 12/13/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import Foundation

class ArticlePresenter{
    var ArticleModels:ArticleModel?
    var ArticleViewInterface:ArticleProtocol?
    
    func LoadArticleView(viewInterface: ArticleProtocol) {
        
        //set delegate
        self.ArticleViewInterface = viewInterface
        ArticleModels = ArticleModel()
        ArticleModels?.ArticlePresenterInterface = self
        
        
        //notify to the caller
        ArticleViewInterface?.LoadArticleView()
    }
    
    func loadArticleData(page: Int, Limite: Int){
        ArticleModels?.loadArticleData(page,Limite)
    }
}
extension ArticlePresenter:ArticlePresenterProtocol{
    func responeData(data: [Article]) {
        ArticleViewInterface?.UpdateArticle(data)
    }
}
