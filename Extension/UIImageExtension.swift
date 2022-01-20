//
//  UIImageExtension.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/12.
//

import UIKit

extension UIImage {
    
    class func resizeImage(at url: URL, for size: CGSize) -> UIImage? {
            guard let image = UIImage(contentsOfFile: url.path) else {
                return nil
            }
            
            let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: size)
            
            return renderer.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: size))
            }
     }
    
}
