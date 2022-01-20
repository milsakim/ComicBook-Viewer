//
//  LoadDate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit

extension ComicBookListController {
    
    // MARK: - Fetch Data
    
    func fetchData() -> Bool {
        if category != nil {
            comicBooks = category!.comicBooks?.allObjects as? [ComicBook]
            
            if comicBooks != nil {
                comicBooks!.sort(by: {
                    $0.creationDate! > $1.creationDate!
                })
            }
            return true
        } else {
            return false
        }
    }
    
}
