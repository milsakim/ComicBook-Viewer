//
//  CreateComicBookViewDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit

extension ComicBookListController: CreateComicBookViewDelegate { 
    
    // MARK: - Create Comic Book View Delegate Methods
    
    func didFinishCreatingComicBook(success: Bool) {
        print("--- didFinishCreating() ---")
        
        if success {
            reloadTableView()
        }
        
        // removeView()
        
        backgroundView?.removeFromSuperview()
        createComicBookView?.baseView.removeFromSuperview()
        createComicBookView = nil
    }
    
    func removeView() {
        print("--- removeView() ---")
        
        backgroundView?.removeFromSuperview()
        createComicBookView?.baseView.removeFromSuperview()
        createComicBookView = nil
    }
    
    func presentImagePicker(controller: UIImagePickerController) {
        present(controller, animated: true, completion: nil)
    }
    
    func dismissImagePicker() {
        dismiss(animated: true, completion: nil)
    }

}
