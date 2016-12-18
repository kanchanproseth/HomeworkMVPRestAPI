//
//  MultiUploadPresenter.swift
//  RestMVP
//
//  Created by Cyberk on 12/18/16.
//  Copyright © 2016 Cyberk. All rights reserved.
//

import UIKit

class MultiUploadPresenter{
    var MultiUploadModels:MultiUploadModel?
    
    func uploadMultiImage(Data: [UIImage]){
        MultiUploadModels = MultiUploadModel()
        MultiUploadModels?.UploadMultiImage(data: Data)
    }
}
