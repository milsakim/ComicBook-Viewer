//
//  LoadData.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/04/04.
//

import UIKit
import CoreData

extension CategoryController {
    
    // MARK: - Load Data Related Method
    
    func fetchData() -> Bool {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest = Category.fetchRequest() 
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(ComicBook.creationDate), ascending: true)]
        
        // Perform Fetch Request
        do {
            categories = try CoreDataManager.sharedInstance.managedObjectContext?.fetch(fetchRequest)
           
            return true
        } catch {
            return false
        }
    }
    
}
