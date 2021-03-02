//
//  DocumentPickerController.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/02/21.
//

import UIKit

extension ComicBookController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            print("--- document picker selected url: \(url.path) ---")
        }
        
        if comicBook != nil {
            if CoreDataManager.sharedInstance.addPage(comicBook: comicBook!, imageURLs: urls) {
                reloadCollectionView()
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
}
