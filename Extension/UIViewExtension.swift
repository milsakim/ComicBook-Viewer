//
//  UIViewExtension.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/12.
//

import UIKit

extension UIView {
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
}
