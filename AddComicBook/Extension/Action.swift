//
//  Action.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit

extension CreateComicBookView {
    
    // MARK: - Action
    
    @IBAction func cancel(_ sender: Any) {
        print(#function)
        
        guard let delegate = self.delegate else {
            return
        }
        
        thumbnailImage = nil
        updateThumbnailImageView()
        
        delegate.removeView()
    }
    
    @IBAction func create(_ sender: Any) {
        print(#function)
        
        guard let title = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        let author = authorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let delegate = self.delegate else {
            return
        }
        
        let success = CoreDataManager.sharedInstance.addComicBook(category: category!, title: title, author: author, thumbnail: thumbnailImage)
        
        delegate.didFinishCreatingComicBook(success: success)
    }
    
    @IBAction func importImage(_ sender: Any) {
        print(#function)
        
        if imagePickerController == nil {
            imagePickerController = UIImagePickerController()
            imagePickerController!.delegate = self
            imagePickerController!.sourceType = .photoLibrary
        }
        
        if imagePickerController != nil, delegate != nil {
            delegate!.presentImagePicker(controller: imagePickerController!)
        }
    }
    
}
