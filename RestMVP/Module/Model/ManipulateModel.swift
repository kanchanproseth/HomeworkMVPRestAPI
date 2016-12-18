//
//  ManipulateModel.swift
//  RestMVP
//
//  Created by Kan Chanproseth on 12/16/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit

class ManipulateModel{
    var ManipulatePresenterInterface: ManipulatePresenter?
    
    
    func uploadImage(_ title:String ,_ descriptionsOfPost: String,_ image: Data){
        print("2******\(image)")
        
            
        var jsonData: String?
        let urlImage = URL(string: "http://120.136.24.174:1301/v1/api/uploadfile/single")
        
        var uploadImage = URLRequest(url: urlImage!)
        let boundary = "Boundary-\(UUID().uuidString)"
        
        uploadImage.setValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
        uploadImage.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        uploadImage.httpMethod = "POST"
        uploadImage.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        var formData = Data()
        let mimeType = "image/png" // Multipurpose Internet Mail Extension
        
        // Image
        formData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"FILE\"; filename=\"Image.png\"\r\n".data(using: .utf8)!)
        formData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        formData.append(image)
        formData.append("\r\n".data(using: .utf8)!)
        formData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        do {
            uploadImage.httpBody = formData
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        let uploadTask = URLSession.shared.dataTask(with: uploadImage) {
            (data, response, error) in
            
            if error != nil {
                
                print(error as Any)
                
            } else {
                
                if let urlContent = data {
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        jsonData = jsonResult["DATA"] as? String
                        //  Notify to presenter
                        self.ManipulatePresenterInterface?.responeImageData(title: title,descriptionsOfPost: descriptionsOfPost,data: jsonData!)
                        print(jsonData!)
                        
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                }
            }
        }
        uploadTask.resume()
        
    }
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }

    func PostArticleData(_ title: String,_ descriptionsOfPost: String, image: String){
        
       
        
        print("\(title)\(descriptionsOfPost)\(image)")
        let json = [   "TITLE": title,
                       "DESCRIPTION": descriptionsOfPost,
                       "AUTHOR": 0,
                       "CATEGORY_ID": 0,
                       "STATUS": "string",
                       "IMAGE": image] as [String : Any]
        
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            // create post request
            let endpoint: String = "http://120.136.24.174:1301/v1/api/articles"
            let session = URLSession.shared
            let url = NSURL(string: endpoint)!
            let request = NSMutableURLRequest(url: url as URL)
            request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
            request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "content-type")
            request.addValue("*/*", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            print("aaaaasdasdasdiashkfjhsfgkshdgfyagkfghasgkfghsgdfkalsdgjfh")
            
            let task = session.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                print(response as! HTTPURLResponse)
            }
            task.resume()
        } catch {
            print("bad things happened")
        }

        
        
    }
    
    func delete(id: Int){
        
        
        do {
            
            
            // create post request
            let endpoint: String = "http://120.136.24.174:1301/v1/api/articles/\(id)"
            let session = URLSession.shared
            let url = NSURL(string: endpoint)!
            let request = NSMutableURLRequest(url: url as URL)
            request.addValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
            request.addValue("*/*", forHTTPHeaderField: "Accept")
            request.httpMethod = "DELETE"
            
            // insert json data to the request
            print("***************************************************")
            
            let task = session.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                print(response as! HTTPURLResponse)
            }
            task.resume()
        } catch {
            print("bad things happened")
        }

        
        
    }
    

}
