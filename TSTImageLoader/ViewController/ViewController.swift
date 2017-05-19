//
//  ViewController.swift
//  TSTImageLoader
//
//  Created by Vitalii Obertynskyi on 5/19/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var objects: [ImageModel] = []
    fileprivate var imageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateMOC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // clean memory a little bit
        let currCell = self.tableView.visibleCells.first!
        if let currentIndex = self.tableView.indexPath(for: currCell)?.row {
            for index in 0..<currentIndex {
                let model = self.objects[index]
                model.image = nil
            }
        }
    }
    
    func generateMOC() {
        
        for index in 1...10000 {
            
            let tmp = "http://loremflickr.com/320/240/city,cat,dog,girl,car?randome=".appendingFormat("%d", index)
            let model = ImageModel(imageUrl: tmp, image: nil)
            self.objects.append(model)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! ImageCell
        
        let model = self.objects[indexPath.row]
        
        if model.loadFileFromCache() == nil {

            self.imageDownloader.downloadImage(with: model, completion: {
                
                DispatchQueue.main.sync {
                 
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                    tableView.endUpdates()
                }
            })
            
        } else {
            
            cell.imgView.image = model.image
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.ident()) as! ImageCell
        
        cell.imgView.image = UIImage(named: "placholder")
        cell.titleLabel.text = String().appendingFormat("Index: %d", indexPath.row)
        
        return cell
    }
}
