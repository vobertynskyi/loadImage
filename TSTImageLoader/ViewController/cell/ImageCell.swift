//
//  ImageCell.swift
//  TSTImageLoader
//
//  Created by Vitalii Obertynskyi on 5/19/17.
//  Copyright © 2017 vobertynskyi. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static func ident() -> String {
        return "ImageCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.layer.borderColor = UIColor.white.cgColor
        self.imgView.layer.borderWidth = 4
    }
}
