//
//  UISetup.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/30.
//

import UIKit

extension PageViewController {
    
    // MARK: - Scroll View Setup Related Methods
    
    func setupScrollView(size: CGSize) {
        // Load image
        if image == nil {
            loadImage()
        }
        
        scrollView.delegate = self
        scrollView.backgroundColor = .black
        scrollView.bounds.size = size
        
        // Configure scroll view's content size
        scrollView.contentSize = calculateSizeByOrientation(viewSize: size)
        
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = (image!.size.width / size.width)
        // scrollView.zoomScale = 1
        
        print(#function)
        print("--- scrollView.bounds.size: \(scrollView.bounds.size) ---")
        print("--- scrollView.contentSize: \(scrollView.contentSize) ---")
    }
    
    func updateContentSize(size: CGSize) {
        scrollView.contentSize = size
    }
    
    // MARK: - Image View Setup Related Methods
    
    func setupImageView(size: CGSize) {
        if imageView == nil {
            imageView = UIImageView()
        }
        
        imageView!.image = image
        imageView!.bounds.size = calculateSizeByOrientation(viewSize: size)
        imageView!.backgroundColor = .black
        
        // Add image view as scroll view's sub view
        scrollView.addSubview(imageView!)
        
        // Update image view's center
        updateCenter(superViewSize: size)
        
        scrollView.zoomScale = 1
        
        scrollView.setNeedsDisplay()
    }
    
    func updateCenter(superViewSize: CGSize) {
        if imageView == nil {
            return
        }
        
        let offsetX: CGFloat = max(0, (superViewSize.width - scrollView.contentSize.width) / 2)
        let offsetY: CGFloat = max(0, (superViewSize.height - scrollView.contentSize.height) / 2)
        let newCenter: CGPoint = CGPoint(x: (scrollView.contentSize.width / 2) + offsetX, y: (scrollView.contentSize.height / 2) + offsetY)
        
        imageView!.center = newCenter
    }
    
    // MARK: - Calculating View's Size Related Methods
    
    func calculateSizeByOrientation(viewSize: CGSize) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        
        if image == nil {
            loadImage()
        }
        
        if viewSize.width > viewSize.height {
            width = image!.size.width * viewSize.height / image!.size.height
            height = viewSize.height
        } else {
            width = viewSize.width
            height = image!.size.height * viewSize.width / image!.size.width
        }
        
        return CGSize(width: width, height: height)
    }
    
}

