//
//  CoreDataManager.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/29.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Property
    
    let modelName: String = "ComicBookViewer"
    
    var managedObjectModel: NSManagedObjectModel? = nil
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // MARK: - Shared Instance
    
    static let sharedInstance: CoreDataManager = CoreDataManager()
    
    // MARK: - Initializer
    
    private init() {
        print("--- CoreDataManager init() called ---")
    }
    
    // MARK: - Creating Core Data Stack
    
    private func createCoreDataStack() {
        
    }
    
    private func createManagedObjectModel() {
        if managedObjectModel == nil {
            // Fetch Model URL
            guard let modelURL: URL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
                fatalError("--- Unable to fetch model URL ---")
            }
            
            // Initialize Managed Object Model
            managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        }
    }
    
    private func createPersistentStoreCoordinator() {
        if managedObjectModel == nil {
            createManagedObjectModel()
        }
        
        if persistentStoreCoordinator == nil {
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
            
            let persistentStoreName: String = "\(modelName).sqlited"
            
            let fileManager: FileManager = FileManager.default
            let urls: [URL] = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            
            if urls.count > 0 {
                let documentDirectoryURL: URL = urls[0]
                let defaultDirectoryURL: URL = documentDirectoryURL.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
                let persistentStoreURL: URL = defaultDirectoryURL.appendingPathComponent(persistentStoreName)
                
                print("--- persistentStoreURL: \(persistentStoreURL.path) ---")
                
                do {
                    let options: [String:Bool] = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
                    
                    if persistentStoreCoordinator != nil {
                        try persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
                    }
                } catch {
                    fatalError("--- Unable to add persistent store ---")
                }
            }
        }
    }
    
    private func createManagedObjectContext() {
        if persistentStoreCoordinator == nil {
            createPersistentStoreCoordinator()
        }
        
        if managedObjectContext == nil {
            // Initialize Managed Object Context
            managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            
            // Configure Managed Object Context
            if managedObjectContext != nil {
                managedObjectContext?.persistentStoreCoordinator = persistentStoreCoordinator
            }
        }
    }
    
    // MARK: - Add New Managed Object
    
    func addNewCategory(title: String) -> UUID? {
        if managedObjectContext != nil {
            let category: Category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: managedObjectContext!) as! Category
            
            category.id = UUID()
            category.title = title
            category.creationDate = Date()
            category.modificationDate = Date()
            category.lastAccessedDate = Date()
            
            return category.id
        } else {
            return nil
        }
    }
    
    func addNewComicBook(category: Category?, title: String, author: String?) -> UUID? {
        if managedObjectContext != nil, category != nil {
            let comicBook: ComicBook = NSEntityDescription.insertNewObject(forEntityName: "ComicBook", into: managedObjectContext!) as! ComicBook
            
            comicBook.id = UUID()
            comicBook.title = title
            
            if author != nil {
                comicBook.author = author
            } else {
                comicBook.author = "No Author"
            }
            
            comicBook.creationDate = Date()
            comicBook.modificationDate = Date()
            comicBook.lastAccessedDate = Date()
            
            let comicBooks: NSMutableSet = category!.comicBooks as! NSMutableSet
            comicBooks.add(comicBook)
            category!.comicBooks = comicBooks
            
            if save() {
                // Get Default File Manager
                let fileManager: FileManager = FileManager.default
                
                let urls: [URL] = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
                
                if urls.count > 0 {
                    let documentDirectoryURL: URL = urls[0]
                    let defaultDirectoryURL: URL = documentDirectoryURL.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
                    let comicBookURL: URL = defaultDirectoryURL.appendingPathComponent(comicBook.id!.uuidString)
                    
                    do {
                        try fileManager.createDirectory(at: comicBookURL, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        print("--- fail to create comic book ---")
                    }
                }
                
                return comicBook.id
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func addNewPage(comicBook: ComicBook?, height: CGFloat?, width: CGFloat?) -> UUID? {
        if managedObjectContext != nil, comicBook != nil, height != nil, width != nil {
            let page: Page = NSEntityDescription.insertNewObject(forEntityName: "Page", into: managedObjectContext!) as! Page
            
            page.id = UUID()
            page.height = Double(height!)
            page.width = Double(width!)
            page.index = 1
            
            
            
            return page.id
        } else {
            return nil
        }
    }
    
    // MARK: - Saving Managed Object
    func save() -> Bool {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
                return true
            } catch {
                print("--- Unable to save managed object context ---")
                print("\(error), \(error.localizedDescription)")
                return false
            }
        } else {
            print("--- No changes has made to managed object context ---")
            return true
        }
    }
    
}
