//
//  UISetup.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit

extension CategoryController {
    
    func setupButtons() {
        if addButton == nil {
            addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        }
        
        if editButton == nil {
            editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
        }
        
        if doneButton == nil {
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTable))
        }
        
        if tableView.isEditing {
            navigationItem.setRightBarButtonItems([doneButton!, addButton!], animated: true)
        } else {
            navigationItem.setRightBarButtonItems([editButton!, addButton!], animated: true)
        }
    }
    
}
