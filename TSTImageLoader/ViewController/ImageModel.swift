//
//  ImageModel.swift
//  TSTImageLoader
//
//  Created by Vitalii Obertynskyi on 5/19/17.
//  Copyright © 2017 vobertynskyi. All rights reserved.
//

import Foundation
import UIKit

class ImageModel {
    
    var imageUrl: String = ""
    var image: UIImage?
    
    init(imageUrl: String, image: UIImage? = nil) {
        
        self.imageUrl = imageUrl
        self.image = image
    }
    
    func loadFileFromCache() -> UIImage? {
        
        if image != nil {
            return image
        }
        
        let fileManager = FileManager.default
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileName = String(self.imageUrl.hash)
        path = path?.appending("/").appending(fileName)
        
        if fileManager.fileExists(atPath: path!) {
            
            self.image = UIImage(contentsOfFile: path!)
            return self.image
            
        }
        
        return nil
    }
    
    func saveFileToCache(image: UIImage) {
        
        self.image = image
        
        let fileManager = FileManager.default
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileName = String(self.imageUrl.hash)
        path = path?.appending("/").appending(fileName)
        
        fileManager.createFile(atPath: path!, contents: UIImageJPEGRepresentation(image, 0.9), attributes: nil)
    }
}
