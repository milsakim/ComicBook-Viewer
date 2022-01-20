//
//  ImagePickerControllerDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/21.
//

import UIKit

extension CreateComicBookView: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImageURL: URL? = info[UIImagePickerController.InfoKey.imageURL] as? URL
        
        print("--- selected image URL: \(selectedImageURL?.path) ---")
        
        if selectedImageURL != nil {
            createThumbnail(url: selectedImageURL!)
        }
        
        if delegate != nil {
            delegate!.dismissImagePicker()
        }
    }
    
}
