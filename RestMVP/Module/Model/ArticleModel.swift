//
//  ArticleModel.swift
//  RestMVP
//
//  Created by Cyberk on 12/13/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import Foundation

class ArticleModel{
    var ArticlePresenterInterface: ArticlePresenter?
    
    
    
    func loadArticleData(_ page:Int, _ limit:Int){
        let url = URL(string: "http://120.136.24.174:1301/v1/api/articles?page=\(page)&limit=\(limit)")
        var request = URLRequest(url: url!)
        request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
  
        let task = session.dataTask(with: request, completionHandler: {
            data, response, error in
            //            print("Finish")
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    var articles:[Article] = []
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        let data = json["DATA"] as! [AnyObject]
                        let pagintion = json["PAGINATION"] as! [String:Any]
                        TOTAL_PAGE = pagintion["TOTAL_PAGES"] as! Int
                        print(TOTAL_PAGE)
                        for eachData in data {
                            let article = Article()
                            let eachData = eachData as! [String:AnyObject]
                            if !(eachData["TITLE"] is NSNull) {
                                article.title = eachData["TITLE"] as? String
                             }
                            if !(eachData["ID"] is NSNull)  {
                                article.id = eachData["ID"] as! Int
                            }
                            if !(eachData["DESCRIPTION"] is NSNull) {
                                article.description = eachData["DESCRIPTION"] as? String
                                
                            }
                            if !(eachData["IMAGE"] is NSNull) && eachData["IMAGE"] != nil {
                                article.image = eachData["IMAGE"] as? String
                            }
                            articles.append(article)
                        }
                        self.ArticlePresenterInterface?.responeData(data: articles)
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        })
        
        task.resume()
        
    }
   
}
