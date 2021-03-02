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
        
        createCoreDataStack()
    }
    
    // MARK: - Creating Core Data Stack
    
    private func createCoreDataStack() {
        createManagedObjectModel()
        createPersistentStoreCoordinator()
        createManagedObjectContext()
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
    
    /*
    func addNewCategory(title: String) -> UUID? {
        if managedObjectContext != nil {
            let category: Category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: managedObjectContext!) as! Category
            
            category.id = UUID()
            category.title = title
            category.creationDate = Date()
            category.modificationDate = Date()
            category.lastAccessedDate = Date()
            
            if save() {
                return category.id
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    */
    
    func addCategory(title: String) -> Category? {
        if managedObjectContext != nil {
            let category: Category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: managedObjectContext!) as! Category
            
            category.id = UUID()
            category.title = title
            category.creationDate = Date()
            category.modificationDate = Date()
            category.lastAccessedDate = Date()
            
            if save() {
                return category
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    /*
    func addComicBook(category: Category?, title: String, author: String?, thumbnail: UIImage?) -> UUID? {
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
            
            comicBook.category = category
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
                        
                        if let thumbnail = thumbnail {
                            let jpegData = thumbnail.jpegData(compressionQuality: 1.0)
                        }
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
    */
    
    func addComicBook(category: Category?, title: String, author: String?, thumbnail: UIImage?) -> Bool {
        if managedObjectContext != nil, category != nil {
            let comicBook: ComicBook = NSEntityDescription.insertNewObject(forEntityName: "ComicBook", into: managedObjectContext!) as! ComicBook
            
            comicBook.id = UUID()
            comicBook.title = title
            
            if author != nil {
                comicBook.author = author
            } else {
                comicBook.author = "No Author"
            }
            
            let comicBookURL = getDirectory(uuid: comicBook.id!.uuidString)
            var thumbnailURL: URL? = nil
            
            if thumbnail != nil, comicBookURL != nil {
                thumbnailURL = comicBookURL!.appendingPathComponent("\(comicBook.id!.uuidString).jpg")
                print("--- thumbnail path: \(thumbnailURL!.path) ---")
            }
            
            comicBook.thumbnail = thumbnailURL?.path
            
            comicBook.creationDate = Date()
            comicBook.modificationDate = Date()
            comicBook.lastAccessedDate = Date()
            
            comicBook.category = category
            let comicBooks: NSMutableSet = category!.comicBooks as! NSMutableSet
            comicBooks.add(comicBook)
            category!.comicBooks = comicBooks
            
            if save() {
                if comicBookURL != nil {
                    do {
                        let fileManager: FileManager = FileManager.default
                        try fileManager.createDirectory(at: comicBookURL!, withIntermediateDirectories: true, attributes: nil)
                        
                        if thumbnailURL != nil {
                            let jpeg = thumbnail!.jpegData(compressionQuality: 1.0)
                            
                            if jpeg != nil {
                                do {
                                    try jpeg?.write(to: thumbnailURL!)
                                } catch {
                                    print("--- Fail to Save ComicBook's Thumbnail ---")
                                }
                            }
                        }
                    } catch {
                        print("--- fail to create comic book ---")
                    }
                }
                
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func addPage(comicBook: ComicBook, imageURLs: [URL]) -> Bool {
        if managedObjectContext != nil {
            let comicBookDirectory: URL? = getDirectory(uuid: comicBook.id!.uuidString)
            var index: Int = comicBook.pages?.count ?? 0
            
            if comicBookDirectory != nil {
                let fileManager: FileManager = FileManager.default
                
                for url in imageURLs {
                    url.startAccessingSecurityScopedResource()
                    
                    let page: Page = NSEntityDescription.insertNewObject(forEntityName: "Page", into: managedObjectContext!) as! Page
                    
                    page.id = UUID()
                    page.index = Int64(index)
                    
                    let imgData: NSData = try! NSData(contentsOf: url)
                    let imageSource = CGImageSourceCreateWithData(imgData as CFData, nil)
                    let properties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil)! as NSDictionary
                    
                    page.width = properties["PixelWidth"] as! Double
                    page.height = properties["PixelHeight"] as! Double
                    
                    page.comicBook = comicBook
                    let pages = comicBook.pages as! NSMutableSet
                    pages.add(page)
                    comicBook.pages = pages
                    
                    let imageURL: URL = comicBookDirectory!.appendingPathComponent("\(page.id!.uuidString).jpg")
                    let thumbnailURL: URL = comicBookDirectory!.appendingPathComponent("\(page.id!.uuidString)-thumbnail.jpg")
                    
                    let size: CGSize = CGSize(width: 120, height: 160)
                    let resizedImage = resizeImage(at: url, for: size)
                    
                    if resizedImage != nil {
                        if let data = resizedImage!.jpegData(compressionQuality: 0.5) {
                            do {
                                try data.write(to: thumbnailURL)
                                try fileManager.copyItem(at: url, to: imageURL)
                            } catch {
                                return false
                            }
                        }
                    }
                   
                    index += 1
                }
                
                if save() {
                    return true
                } else {
                    return false
                }
            }
            
            return false
        } else {
            return false
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
    
    // MARK: - Delete Managed Objec
    
    func deleteCategory(category: Category?) -> Bool {
        if category != nil, managedObjectContext != nil {
            managedObjectContext!.delete(category!)
            
            if save() {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    // MARK: - Save Managed Object
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
    
    // MARK: - Get Directory Path
    
    func getDirectory(uuid: String) -> URL? {
        let fileManager: FileManager = FileManager.default
        
        let urls: [URL] = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if urls.count > 0 {
            let documentDirectoryURL: URL = urls[0]
            let defaultDirectoryURL: URL = documentDirectoryURL.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
            let directoryURL: URL = defaultDirectoryURL.appendingPathComponent(uuid)
            
            print("--- getDirectory: \(directoryURL.absoluteString) ---")
            return directoryURL
        }
        
        return nil
    }
    
    // MARK: - Image Resizing Method
    
    func resizeImage(at url: URL, for size: CGSize) -> UIImage? {
        guard let image = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
