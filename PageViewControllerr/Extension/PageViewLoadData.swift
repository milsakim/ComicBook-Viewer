//
//  PageViewLoadData.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/30.
//

import UIKit

extension PageViewController {
    
    func loadImage() {
        if imageURL != nil {
            let fileManager: FileManager = FileManager.default
            
            if fileManager.fileExists(atPath: imageURL!.path) {
                image = UIImage(contentsOfFile: imageURL!.path)
            }
        }
    }
    
}
