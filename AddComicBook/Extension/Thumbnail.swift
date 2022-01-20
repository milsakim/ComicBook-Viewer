//
//  Thumbnail.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit

extension CreateComicBookView {
    
    // MARK: - Thumbnail Related Methods
    
    func createThumbnail(url: URL) {
        let frameImage: UIImage? = UIImage(named: "ThumbnailFrame")
        let selectedImage: UIImage? = UIImage(contentsOfFile: url.path)
        
        if frameImage != nil, selectedImage != nil {
            let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: frameImage!.size)
            
            UIGraphicsBeginImageContextWithOptions(frameImage!.size, false, frameImage!.scale)
            
            selectedImage!.draw(in: rect)
            frameImage!.draw(in: rect)
            
            thumbnailImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
        }
    }
    
    func updateThumbnailImageView() {
        if thumbnailImage != nil {
            thumbnailImageView.image = thumbnailImage
        } else {
            thumbnailImageView.image = UIImage(named: "NoSelectedThumbnail")
        }
    }
    
}
