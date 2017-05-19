//
//  ImageDownloader.swift
//  TSTImageLoader
//
//  Created by Vitalii Obertynskyi on 5/19/17.
//  Copyright © 2017 vobertynskyi. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {

    private var downloaderQueue = OperationQueue()
    private var urlSession = URLSession(configuration: URLSessionConfiguration.default)
    private var fileManager = FileManager.default
    
    override init() {
        super.init()
        
        downloaderQueue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
    }
    
    func downloadImage(with model: ImageModel, completion: @escaping ()->()) {
        
        self.downloaderQueue.addOperation {
        
            var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let fileName = String(model.imageUrl.hash)
            path = path?.appending("/").appending(fileName)
            
            let url = URL(string: model.imageUrl)
            self.urlSession.dataTask(with: url!, completionHandler: { (data, responce, error) in
                
                if error == nil && data != nil {
                    
                    self.fileManager.createFile(atPath: path!, contents: data, attributes: nil)
                    completion()
                } else {
                    
                    print("Error load image: %@", error?.localizedDescription ?? "")
                    
                }
            }).resume()
        }
    }
}

